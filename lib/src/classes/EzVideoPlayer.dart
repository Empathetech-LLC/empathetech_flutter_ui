library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

/// [EzVideoPlayer] control buttons visibility state
enum ButtonVis {
  alwaysOff,
  alwaysOn,
  auto,
}

class EzVideoPlayer extends StatefulWidget {
  final VideoPlayerController controller;

  /// [Color] shared by all icons/buttons
  final Color iconColor;

  /// [Color.withOpacity] value that should be used when the player is not in focus
  /// Default: 0.0
  final double hiddenOpacity;

  /// [Container] decoration for the region behind the controls
  /// Default: [BoxDecoration] -> color: [Colors.transparent]
  final Decoration controlsBackground;

  /// Whether the position of the button controls should be swapped when
  /// [EzConfig.dominantSide] is set to [Hand.left]
  /// Default: true
  final bool reverseHands;

  /// [ButtonVis] for the play/pause buttons
  /// Default: [ButtonVis.auto]
  final ButtonVis playVis;

  /// [ButtonVis] for the volume slider
  /// Default: [ButtonVis.auto]
  final ButtonVis volumeVis;

  /// [ButtonVis] for the replay button
  /// Default: [ButtonVis.auto]
  final ButtonVis replayVis;

  /// [ButtonVis] for the time slider
  /// Default: [ButtonVis.alwaysOff]
  final ButtonVis sliderVis;

  /// Whether buttons set to [ButtonVis.auto] should always show when the video is paused
  /// Default: false
  final bool showOnPause;

  /// Whether the video should play on init
  /// Default: true
  final bool autoPlay;

  /// Whether the video should replay upon completion
  /// Default: false
  final bool autoLoop;

  /// What volume the video should start with
  /// Default: 0.0
  final double startingVolume;

  /// [BoxConstraints] maximum width for the play area
  /// Default: [double.infinity]
  final double maxWidth;

  /// [BoxConstraints] maximum height for the play area
  /// Default: [double.infinity]
  final double maxHeight;

  /// [Stack]s play, mute, and replay buttons on top of an [AspectRatio] for the [controller]
  /// Also supports tap-to-pause on the main window via [EzMouseDetector]
  /// The visibility of each button can be controlled with [ButtonVis]
  /// Optionally provide a [BoxDecoration] background for the controls region
  /// The video will begin muted unless [startingVolume] is specified
  /// Optionally provide [maxWidth] and [maxHeight] to shape the video
  EzVideoPlayer({
    Key? key,
    required this.controller,
    required this.iconColor,
    this.hiddenOpacity = 0.0,
    this.controlsBackground = const BoxDecoration(color: Colors.transparent),
    this.reverseHands = true,
    this.playVis = ButtonVis.auto,
    this.volumeVis = ButtonVis.auto,
    this.replayVis = ButtonVis.auto,
    this.sliderVis = ButtonVis.alwaysOff,
    this.showOnPause = false,
    this.autoPlay = true,
    this.autoLoop = false,
    this.startingVolume = 0.0,
    this.maxWidth = double.infinity,
    this.maxHeight = double.infinity,
  }) : super(key: key);

  @override
  _EzVideoPlayerState createState() => _EzVideoPlayerState();
}

class _EzVideoPlayerState extends State<EzVideoPlayer> {
  bool show = false;

  double? savedVolume;
  double _currentPosition = 0.0;

  late double aspectRatio = widget.controller.value.aspectRatio;

  late double margin = EzConfig.prefs[marginKey];
  late double buttonSpacer = EzConfig.prefs[buttonSpacingKey];

  late Color showing = widget.iconColor;
  late Color hiding = widget.iconColor.withOpacity(widget.hiddenOpacity);

  void _playVideo() {
    setState(() {
      widget.controller.play();
    });
  }

  void _pauseVideo() {
    setState(() {
      widget.controller.pause();
    });
  }

  void _muteVideo() {
    setState(() {
      savedVolume = widget.controller.value.volume;
      widget.controller.setVolume(0.0);
    });
  }

  void _unMuteVideo() {
    setState(() {
      widget.controller.setVolume(savedVolume ?? 1.0);
    });
  }

  void _replayVideo() {
    setState(() {
      widget.controller.pause();
      widget.controller.seekTo(Duration.zero);
      widget.controller.play();
    });
  }

  /// Get the percent of the total video that is complete from the passed [Duration]
  double _percentComplete(Duration position) {
    return (position.isNegative || position.inMilliseconds == 0)
        ? 0
        : position.inMilliseconds /
            widget.controller.value.duration.inMilliseconds;
  }

  /// Get the [Duration] value that corresponds to the passed [completion] percentage
  Duration _findPoint(double completion) {
    return Duration(
      milliseconds:
          (widget.controller.value.duration.inMilliseconds * completion)
              .round(),
    );
  }

  @override
  void initState() {
    super.initState();

    widget.controller.setVolume(widget.startingVolume);

    // It seems that when autoLoop is false, the asset can sometimes be unloaded
    // Personally, (autoLoop == false) != (being able to play again at all == false)
    // Se we add this workaround
    widget.controller.setLooping(true);

    widget.controller.addListener(() {
      setState(() {
        _currentPosition = _percentComplete(widget.controller.value.position);

        if (!widget.autoLoop && _currentPosition >= 0.99) {
          _pauseVideo();
        }
      });
    });

    if (widget.autoPlay) widget.controller.play();
  }

  Color _buildColor(ButtonVis visibility) {
    switch (visibility) {
      case ButtonVis.alwaysOff:
        return Colors.transparent;
      case ButtonVis.alwaysOn:
        return showing;
      case ButtonVis.auto:
        return (show)
            ? showing
            : (widget.showOnPause && !widget.controller.value.isPlaying)
                ? showing
                : hiding;
    }
  }

  List<Widget> _buildButtons({required SliderThemeData videoSliderTheme}) {
    List<Widget> controls = [];

    // Play/pause
    if (widget.playVis != ButtonVis.alwaysOff)
      controls.addAll([
        EzMouseDetector(
          child: Icon(
            (widget.controller.value.isPlaying)
                ? PlatformIcons(context).pause
                : PlatformIcons(context).playArrow,
            color: _buildColor(widget.playVis),
          ),
          onTap: () {
            if (widget.controller.value.position >=
                widget.controller.value.duration) {
              // Video has ended, replay
              _replayVideo();
            } else {
              (widget.controller.value.isPlaying)
                  ? _pauseVideo()
                  : _playVideo();
            }
          },
        ),
        Container(width: buttonSpacer),
      ]);

    // Volume
    if (widget.volumeVis != ButtonVis.alwaysOff)
      controls.addAll([
        // Mute button
        EzMouseDetector(
          child: Icon(
            (widget.controller.value.volume == 0.0)
                ? PlatformIcons(context).volumeMute
                : PlatformIcons(context).volumeUp,
            color: _buildColor(widget.volumeVis),
          ),
          onTap: () {
            (widget.controller.value.volume == 0.0)
                ? _unMuteVideo()
                : _muteVideo();
          },
        ),
        Container(width: EzConfig.prefs[paddingKey]),

        // Value slider
        Container(
          child: SliderTheme(
            data: videoSliderTheme,
            child: Slider(
              value: widget.controller.value.volume,
              onChanged: (double value) {
                setState(() {
                  widget.controller.setVolume(value);
                });
              },
            ),
          ),
        ),
        Container(width: buttonSpacer),
      ]);

    // Replay
    if (widget.replayVis != ButtonVis.alwaysOff)
      controls.addAll([
        EzMouseDetector(
          child: Icon(PlatformIcons(context).refresh,
              color: _buildColor(widget.replayVis)),
          onTap: _replayVideo,
        ),
        Container(width: buttonSpacer),
      ]);

    return controls;
  }

  @override
  Widget build(BuildContext context) {
    Color sliderColor = _buildColor(widget.sliderVis);

    SliderThemeData videoSliderTheme = SliderThemeData(
      thumbShape: (sliderColor == Colors.transparent)
          ? SliderComponentShape.noThumb
          : null,
      overlayShape: SliderComponentShape.noOverlay,
      trackShape: VideoSliderTrack(),
      activeTrackColor: sliderColor,
      disabledActiveTrackColor: Colors.transparent,
      secondaryActiveTrackColor: sliderColor,
      disabledSecondaryActiveTrackColor: Colors.transparent,
      thumbColor: sliderColor,
      disabledThumbColor: Colors.transparent,
      inactiveTrackColor: sliderColor,
      disabledInactiveTrackColor: Colors.transparent,
    );

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          show = true;
        });
      },
      onExit: (_) {
        setState(() {
          show = false;
        });
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: widget.maxWidth,
          maxHeight: widget.maxHeight,
        ),
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: Stack(
            children: [
              VideoPlayer(widget.controller),

              // Tap-to-pause
              Positioned(
                bottom: heightOf(context) * 0.1,
                left: 0,
                top: 0,
                width: widthOf(context),
                child: EzMouseDetector(
                    child: Container(
                      color: Colors.transparent,
                    ),
                    onTap: () {
                      (widget.controller.value.isPlaying)
                          ? _pauseVideo()
                          : _playVideo();
                    }),
              ),

              // Controls
              Positioned(
                bottom: 0,
                left: margin,
                right: margin,
                height: heightOf(context) * 0.1,
                child: Container(
                  decoration: widget.controlsBackground,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Time seeker
                      SliderTheme(
                        data: videoSliderTheme,
                        child: Slider(
                          value: _currentPosition,
                          onChangeStart: (_) => _pauseVideo,
                          onChanged: (double value) {
                            setState(() {
                              _currentPosition = value;
                              widget.controller.seekTo(_findPoint(value));
                            });
                          },
                        ),
                      ),

                      // Buttons
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            _buildButtons(videoSliderTheme: videoSliderTheme),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VideoSliderTrack extends RoundedRectSliderTrackShape {
  /// Builds a custom slider track with no padding
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
