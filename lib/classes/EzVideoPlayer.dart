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
  final double hiddenOpacity;

  /// [Container] decoration for the region behind the controls
  final Decoration controlsBackground;

  final ButtonVis playVis;
  final ButtonVis volumeVis;
  final ButtonVis replayVis;
  final ButtonVis sliderVis;

  /// Whether buttons set to [ButtonVis.auto] should always show when the video is paused
  final bool showOnPause;

  final bool autoPlay;
  final bool autoLoop;
  final double startingVolume;

  /// [BoxConstraints] maximum width for the play area
  final double maxWidth;

  /// [BoxConstraints] maximum height for the play area
  final double maxHeight;

  /// [Stack]s play, mute, and replay buttons on top of an [AspectRatio] for the [controller]
  /// Also supports tap-to-pause on the main window via [EzMouseDetector]
  /// The visibility of each button can be controlled with [ButtonVis]
  /// Optionally provide a [BoxDecoration] background for the controls region
  /// The video will begin muted unless [startingVolume] is specified
  /// Optionally provide [maxWidth] and [maxHeight] to shape the video
  const EzVideoPlayer({
    Key? key,
    required this.controller,
    required this.iconColor,
    this.hiddenOpacity = 0.0,
    this.controlsBackground = const BoxDecoration(color: Colors.transparent),
    this.playVis = ButtonVis.auto,
    this.volumeVis = ButtonVis.auto,
    this.replayVis = ButtonVis.auto,
    this.sliderVis = ButtonVis.auto,
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

  final double margin = EzConfig.instance.prefs[marginKey];
  final double padding = EzConfig.instance.prefs[paddingKey];
  final double buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];

  late Color showing = widget.iconColor;
  late Color hiding = widget.hiddenOpacity == 0.0
      ? Colors.transparent
      : widget.iconColor.withOpacity(widget.hiddenOpacity);

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

  List<Widget> _buildButtons(SliderThemeData sliderTheme) {
    final buttonSize = buttonSpacer;

    List<Widget> controls = [];

    // Play/pause
    if (widget.playVis != ButtonVis.alwaysOff)
      controls.addAll([
        GestureDetector(
          child: Icon(
            (widget.controller.value.isPlaying)
                ? PlatformIcons(context).pause
                : PlatformIcons(context).playArrow,
            color: _buildColor(widget.playVis),
            size: buttonSize,
          ),
          onTap: () {
            (widget.controller.value.isPlaying) ? _pauseVideo() : _playVideo();
          },
        ),
        EzSpacer.row(buttonSpacer),
      ]);

    // Volume
    if (widget.volumeVis != ButtonVis.alwaysOff)
      controls.addAll([
        // Mute button
        GestureDetector(
          child: Icon(
            (widget.controller.value.volume == 0.0)
                ? PlatformIcons(context).volumeMute
                : PlatformIcons(context).volumeUp,
            color: _buildColor(widget.volumeVis),
            size: buttonSize,
          ),
          onTap: () {
            (widget.controller.value.volume == 0.0)
                ? _unMuteVideo()
                : _muteVideo();
          },
        ),
        EzSpacer.row(padding),

        // Value slider
        Container(
          height: buttonSize,
          width: buttonSize * 3.0,
          child: SliderTheme(
            data: sliderTheme,
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
        EzSpacer.row(buttonSpacer),
      ]);

    // Replay
    if (widget.replayVis != ButtonVis.alwaysOff)
      controls.addAll([
        GestureDetector(
          child: Icon(
            PlatformIcons(context).refresh,
            color: _buildColor(widget.replayVis),
            size: buttonSize,
          ),
          onTap: _replayVideo,
        ),
        EzSpacer.row(buttonSpacer),
      ]);

    return controls;
  }

  @override
  Widget build(BuildContext context) {
    Color sliderColor = _buildColor(widget.sliderVis);

    final SliderThemeData videoSliderTheme =
        Theme.of(context).sliderTheme.copyWith(
              thumbShape: (sliderColor == Colors.transparent)
                  ? SliderComponentShape.noThumb
                  : null,
              activeTrackColor: sliderColor,
              inactiveTrackColor: sliderColor,
              thumbColor: sliderColor,
              trackShape: VideoSliderTrack(),
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
      cursor: SystemMouseCursors.click,
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
                child: GestureDetector(
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
                        children: _buildButtons(videoSliderTheme),
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
