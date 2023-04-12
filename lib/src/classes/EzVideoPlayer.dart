library empathetech_flutter_ui;

import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzVideoPlayer extends StatefulWidget {
  final VideoPlayerController controller;
  final Color iconColor;
  final double? alwaysOn;

  /// [Stack]s play, mute, and replay buttons on top of an [AspectRatio], the recommended parent for [VideoPlayer]s
  /// Optionally provide an opacity value with [alwaysOn] if you want the buttons to persist
  /// Otherwise, the buttons will be transparent until the user hovers over the [VideoPlayer]
  /// Videos begin muted, but the volume will be raised to full upon replay
  const EzVideoPlayer({
    Key? key,
    required this.controller,
    required this.iconColor,
    this.alwaysOn,
  }) : super(key: key);

  @override
  _EzVideoPlayerState createState() => _EzVideoPlayerState();
}

class _EzVideoPlayerState extends State<EzVideoPlayer> {
  bool show = false;

  late double margin = EzConfig.prefs[dialogSpacingKey];

  late Color showing = widget.iconColor;
  late Color hiding = (widget.alwaysOn != null)
      ? widget.iconColor.withOpacity(widget.alwaysOn as double)
      : Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (_) {
        setState(() {
          show = true;
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
                ezClickable(
                  child: ezIcon(
                    (widget.controller.value.isPlaying)
                        ? PlatformIcons(context).playArrow
                        : PlatformIcons(context).pause,
                    color: (show) ? showing : hiding,
                  ),
                  onTap: () {
                    if (widget.controller.value.position >=
                        widget.controller.value.duration) {
                      // Video has ended, replay
                      setState(() {
                        widget.controller.seekTo(Duration.zero);
                        widget.controller.setVolume(1.0);
                        widget.controller.play();
                      });
                    } else {
                      (widget.controller.value.isPlaying)
                          ? setState(() {
                              widget.controller.pause();
                            })
                          : setState(() {
                              widget.controller.play();
                            });
                    }
                  },
                ),
                Container(width: margin),

                // Volume
                ezClickable(
                  child: ezIcon(
                    (widget.controller.value.volume >= 0.0)
                        ? PlatformIcons(context).volumeMute
                        : PlatformIcons(context).volumeOff,
                    color: (show) ? showing : hiding,
                  ),
                  onTap: () {
                    (widget.controller.value.volume >= 0.0)
                        ? setState(() {
                            widget.controller.setVolume(0.0);
                          })
                        : setState(() {
                            widget.controller.setVolume(1.0);
                          });
                  },
                ),

                // Replay
                ezClickable(
                  child: ezIcon(
                    PlatformIcons(context).refresh,
                    color: (show) ? showing : hiding,
                  ),
                  onTap: () {
                    setState(() {
                      widget.controller.seekTo(Duration.zero);
                      widget.controller.setVolume(1.0);
                      widget.controller.play();
                    });
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
