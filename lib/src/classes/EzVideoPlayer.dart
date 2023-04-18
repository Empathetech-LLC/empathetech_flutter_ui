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
  final Color iconColor;

  /// Default: 0.0
  final double hiddenOpacity;

  /// Default:
  /// const BoxDecoration(color: [Colors.transparent])
  final Decoration controlsBackground;

  /// Default: [ButtonVis.auto]
  final ButtonVis playVis;

  /// Default: [ButtonVis.auto]
  final ButtonVis volumeVis;

  /// Default: [ButtonVis.auto]
  final ButtonVis replayVis;

  /// Default: [ButtonVis.alwaysOff]
  /// [ButtonVis.alwaysOn] isn't recommended for slider
  final ButtonVis sliderVis;

  /// Default: true
  final bool autoPlay;

  /// Default: false
  final bool autoLoop;

  /// Default: 0.0
  final double startingVolume;

  /// Default: 0.0
  final double maxWidth;

  /// Default: 0.0
  final double maxHeight;

  /// [Stack]s play, mute, and replay buttons on top of an [AspectRatio], the recommended parent for [VideoPlayer]s
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
    this.playVis = ButtonVis.auto,
    this.volumeVis = ButtonVis.auto,
    this.replayVis = ButtonVis.auto,
    this.sliderVis = ButtonVis.alwaysOff,
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

  late double margin = EzConfig.prefs[marginKey];
  late double buttonSpacer = EzConfig.prefs[buttonSpacingKey];
  late double? iconSize = buildTextStyle(styleKey: dialogContentStyleKey).fontSize;

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
        : position.inMilliseconds / widget.controller.value.duration.inMilliseconds;
  }

  /// Get the [Duration] value that corresponds to the passed [completion] percentage
  Duration _findPoint(double completion) {
    return Duration(
      milliseconds:
          (widget.controller.value.duration.inMilliseconds * completion).round(),
    );
  }

  @override
  void initState() {
    super.initState();

    widget.controller.setVolume(widget.startingVolume);
    widget.controller.setLooping(widget.autoLoop);
    if (widget.autoPlay) widget.controller.play();

    widget.controller.addListener(() {
      setState(() {
        _currentPosition = _percentComplete(widget.controller.value.position);
      });
    });
  }

  Color _buildColor(ButtonVis visibility) {
    switch (visibility) {
      case ButtonVis.alwaysOff:
        return Colors.transparent;
      case ButtonVis.alwaysOn:
        return showing;
      case ButtonVis.auto:
        return (!widget.controller.value.isPlaying || show) ? showing : hiding;
    }
  }

  List<Widget> _buildButtons({
    required double buttonSize,
    required SliderThemeData videoSliderTheme,
  }) {
    List<Widget> controls = [];

    // Play/pause
    if (widget.playVis != ButtonVis.alwaysOff)
      controls.addAll([
        EzMouseDetector(
          child: EzIcon(
            (widget.controller.value.isPlaying)
                ? PlatformIcons(context).pause
                : PlatformIcons(context).playArrow,
            color: _buildColor(widget.playVis),
            size: buttonSize,
          ),
          onTap: () {
            if (widget.controller.value.position >= widget.controller.value.duration) {
              // Video has ended, replay
              _replayVideo();
            } else {
              (widget.controller.value.isPlaying) ? _pauseVideo() : _playVideo();
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
          child: EzIcon(
            (widget.controller.value.volume == 0.0)
                ? PlatformIcons(context).volumeMute
                : PlatformIcons(context).volumeUp,
            color: _buildColor(widget.volumeVis),
            size: buttonSize,
          ),
          onTap: () {
            (widget.controller.value.volume == 0.0) ? _unMuteVideo() : _muteVideo();
          },
        ),
        Container(width: EzConfig.prefs[paddingKey]),

        // Value slider
        Container(
          height: buttonSize,
          width: buttonSize * 4,
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
          child: EzIcon(
            PlatformIcons(context).refresh,
            color: _buildColor(widget.replayVis),
            size: buttonSize,
          ),
          onTap: _replayVideo,
        ),
        Container(width: buttonSpacer),
      ]);

    return controls;
  }

  @override
  Widget build(BuildContext context) {
    double aspectRatio = widget.controller.value.aspectRatio;
    double buttonSize = buildTextStyle(styleKey: buttonStyleKey).fontSize!;
    double cutoff = buttonSize * 4;

    Color sliderColor = _buildColor(widget.sliderVis);

    SliderThemeData videoSliderTheme = SliderThemeData(
      thumbShape:
          (sliderColor == Colors.transparent) ? SliderComponentShape.noThumb : null,
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
                bottom: cutoff,
                left: 0,
                top: 0,
                width: widthOf(context),
                child: EzMouseDetector(
                    child: Container(
                      color: Colors.transparent,
                    ),
                    onTap: () {
                      (widget.controller.value.isPlaying) ? _pauseVideo() : _playVideo();
                    }),
              ),

              // Controls
              Positioned(
                bottom: 0,
                left: margin,
                right: margin,
                height: cutoff,
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
                          onChangeEnd: (_) => _playVideo(),
                        ),
                      ),

                      // Buttons
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildButtons(
                          buttonSize: buttonSize,
                          videoSliderTheme: videoSliderTheme,
                        ),
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
