library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzVideoPlayer extends StatefulWidget {
  final VideoPlayerController controller;
  final Color iconColor;
  final double? alwaysOn;
  final bool autoLoop;
  final bool startMuted;

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
    this.alwaysOn,
    this.autoLoop = false,
    this.startMuted = true,
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
  late Color hiding = (widget.alwaysOn != null)
      ? widget.iconColor.withOpacity(widget.alwaysOn as double)
      : Colors.transparent;

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
      widget.controller.setVolume(1.0);
      widget.controller.play();
    });
  }

  @override
  void initState() {
    super.initState();

    (widget.autoLoop)
        ? widget.controller.setLooping(true)
        : widget.controller.setLooping(false);

    (widget.startMuted)
        ? widget.controller.setVolume(0.0)
        : widget.controller.setVolume(1.0);
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
          AspectRatio(
            aspectRatio: widget.controller.value.aspectRatio,
            child: VideoPlayer(widget.controller),
          ),
          Positioned(
            bottom: margin,
            left: margin,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Play/pause
                EzMouseDetector(
                  child: EzIcon(
                    (widget.controller.value.isPlaying)
                        ? PlatformIcons(context).pause
                        : PlatformIcons(context).playArrow,
                    color: (show) ? showing : hiding,
                  ),
                  onTap: () {
                    if (widget.controller.value.position >=
                        widget.controller.value.duration) {
                      // Video has ended, replay
                      _replayVideo();
                    } else {
                      (widget.controller.value.isPlaying) ? _pauseVideo() : _playVideo();
                    }
                  },
                ),
                Container(width: margin),

                // Volume
                EzMouseDetector(
                  child: EzIcon(
                    (widget.controller.value.volume == 0.0)
                        ? PlatformIcons(context).volumeMute
                        : PlatformIcons(context).volumeUp,
                    color: (show) ? showing : hiding,
                  ),
                  onTap: () {
                    (widget.controller.value.volume == 0.0)
                        ? _unMuteVideo()
                        : _muteVideo();
                  },
                ),
                Container(width: margin),

                // Replay
                EzMouseDetector(
                  child: EzIcon(
                    PlatformIcons(context).refresh,
                    color: (show) ? showing : hiding,
                  ),
                  onTap: () {
                    _replayVideo();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
