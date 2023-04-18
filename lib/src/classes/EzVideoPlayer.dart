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
  final double? width;
  final double? height;
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

  /// Default: 1.0
  final double? replayVolume;

  /// Default: true
  final bool autoPlay;

  /// Default: false
  final bool autoLoop;

  final double startingVolume;

  /// [Stack]s play, mute, and replay buttons on top of an [AspectRatio], the recommended parent for [VideoPlayer]s
  /// Also supports tap-to-pause on the main window via [EzMouseDetector]
  /// The visibility of each button can be controlled with [ButtonVis]
  /// Optionally provide a [BoxDecoration] background for the controls region
  /// The video will begin muted unless [startingVolume] is specified
  /// Only the [height] can set via [EzVideoPlayer]
  /// The width will respond to the parent container
  EzVideoPlayer({
    Key? key,
    this.width,
    this.height,
    required this.controller,
    required this.iconColor,
    this.hiddenOpacity = 0.0,
    this.controlsBackground = const BoxDecoration(color: Colors.transparent),
    this.playVis = ButtonVis.auto,
    this.volumeVis = ButtonVis.auto,
    this.replayVis = ButtonVis.auto,
    this.replayVolume = 1.0,
    this.autoPlay = true,
    this.autoLoop = false,
    this.startingVolume = 0.0,
  }) : super(key: key);

  @override
  _EzVideoPlayerState createState() => _EzVideoPlayerState();
}

class _EzVideoPlayerState extends State<EzVideoPlayer> {
  bool show = false;

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
      widget.controller.setVolume(0.0);
    });
  }

  void _unMuteVideo() {
    setState(() {
      widget.controller.setVolume(1.0);
    });
  }

  void _replayVideo() {
    setState(() {
      widget.controller.seekTo(Duration.zero);

      if (widget.replayVolume != null)
        widget.controller.setVolume(widget.replayVolume as double);

      widget.controller.play();
    });
  }

  @override
  void initState() {
    super.initState();

    widget.controller.setVolume(widget.startingVolume);
    widget.controller.setLooping(widget.autoLoop);
    if (widget.autoPlay) widget.controller.play();
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

  List<Widget> _buildControls() {
    List<Widget> controls = [Container(width: margin)];

    // Play/pause
    if (widget.playVis != ButtonVis.alwaysOff)
      controls.addAll([
        EzMouseDetector(
          child: EzIcon(
            (widget.controller.value.isPlaying)
                ? PlatformIcons(context).pause
                : PlatformIcons(context).playArrow,
            color: _buildColor(widget.playVis),
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
        EzMouseDetector(
          child: EzIcon(
            (widget.controller.value.volume == 0.0)
                ? PlatformIcons(context).volumeMute
                : PlatformIcons(context).volumeUp,
            color: _buildColor(widget.volumeVis),
          ),
          onTap: () {
            (widget.controller.value.volume == 0.0) ? _unMuteVideo() : _muteVideo();
          },
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
          ),
          onTap: _replayVideo,
        ),
      ]);

    return controls;
  }

  @override
  Widget build(BuildContext context) {
    double aspectRatio = widget.controller.value.aspectRatio;
    double cutoff = buildTextStyle(styleKey: buttonStyleKey).fontSize! * 3.0;

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
      child: Container(
        width: widget.width,
        height: widget.height,
        child: Stack(
          children: [
            // Video
            GestureDetector(
              onTap: () {
                (widget.controller.value.isPlaying) ? _pauseVideo() : _playVideo();
              },
              child: AspectRatio(
                aspectRatio: aspectRatio,
                child: VideoPlayer(widget.controller),
              ),
            ),

            // Tap-to-pause
            Positioned(
              bottom: cutoff,
              left: 0,
              top: 0,
              width: screenWidth(context),
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
              left: 0,
              width: screenWidth(context),
              height: cutoff,
              child: Container(
                decoration: widget.controlsBackground,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _buildControls(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
