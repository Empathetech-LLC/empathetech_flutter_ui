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

  /// Default: [Colors.transparent]
  final Color controlsBackground;

  /// Default: [ButtonVis.auto]
  final ButtonVis playVis;

  /// Default: [ButtonVis.auto]
  final ButtonVis volumeVis;

  /// Default: [ButtonVis.auto]
  final ButtonVis replayVis;

  /// Default: 1.0
  final double? replayVolume;

  final bool autoLoop;
  final double startingVolume;

  /// [Stack]s play, mute, and replay buttons on top of an [AspectRatio], the recommended parent for [VideoPlayer]s
  /// Optionally provide an opacity value with [alwaysOn] if you want the buttons to persist
  /// Otherwise, the buttons will be transparent until the user hovers over the [VideoPlayer]
  /// Optionally provide [autoLoop] if you want the video to loop upon completion
  /// Otherwise, the video will automatically pause on the last frame
  /// Videos begin muted, but the volume will be raised to full upon replay
  EzVideoPlayer({
    Key? key,
    required this.controller,
    required this.iconColor,
    this.hiddenOpacity = 0.0,
    this.controlsBackground = Colors.transparent,
    this.playVis = ButtonVis.auto,
    this.volumeVis = ButtonVis.auto,
    this.replayVis = ButtonVis.auto,
    this.replayVolume = 1.0,
    this.autoLoop = false,
    this.startingVolume = 0.0,
  }) : super(key: key);

  @override
  _EzVideoPlayerState createState() => _EzVideoPlayerState();
}

class _EzVideoPlayerState extends State<EzVideoPlayer> {
  bool show = false;

  late double margin = EzConfig.prefs[dialogSpacingKey];
  late double iconSize =
      buildTextStyle(styleKey: dialogContentStyleKey).fontSize ?? margin;

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

    (widget.autoLoop)
        ? widget.controller.setLooping(true)
        : widget.controller.setLooping(false);

    widget.controller.setVolume(widget.startingVolume);
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
            color: (widget.playVis == ButtonVis.alwaysOn)
                ? showing
                : (show)
                    ? showing
                    : hiding,
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
        Container(width: margin),
      ]);

    // Volume
    if (widget.volumeVis != ButtonVis.alwaysOff)
      controls.addAll([
        EzMouseDetector(
          child: EzIcon(
            (widget.controller.value.volume == 0.0)
                ? PlatformIcons(context).volumeMute
                : PlatformIcons(context).volumeUp,
            color: (widget.volumeVis == ButtonVis.alwaysOn)
                ? showing
                : (show)
                    ? showing
                    : hiding,
          ),
          onTap: () {
            (widget.controller.value.volume == 0.0) ? _unMuteVideo() : _muteVideo();
          },
        ),
        Container(width: margin),
      ]);

    // Replay
    if (widget.replayVis != ButtonVis.alwaysOff)
      controls.addAll([
        EzMouseDetector(
          child: EzIcon(
            PlatformIcons(context).refresh,
            color: (widget.replayVis == ButtonVis.alwaysOn)
                ? showing
                : (show)
                    ? showing
                    : hiding,
          ),
          onTap: _replayVideo,
        ),
      ]);

    return controls;
  }

  @override
  Widget build(BuildContext context) {
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
      child: Stack(
        children: [
          // Video
          GestureDetector(
            onTap: () {
              (widget.controller.value.isPlaying) ? _pauseVideo() : _playVideo();
            },
            child: AspectRatio(
              aspectRatio: widget.controller.value.aspectRatio,
              child: VideoPlayer(widget.controller),
            ),
          ),

          // Controls
          Positioned(
            bottom: 0,
            left: 0,
            width: screenWidth(context),
            height: buildTextStyle(styleKey: buttonStyleKey).fontSize! * 2.0,
            child: Container(
              color: widget.controlsBackground,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: _buildControls(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
