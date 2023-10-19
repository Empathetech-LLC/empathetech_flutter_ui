/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../empathetech_flutter_ui.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class EzVideoPlayer extends StatefulWidget {
  final VideoPlayerController controller;

  /// [String] description for screen readers
  final String semantics;

  /// [Color] shared by all icons/buttons
  final Color iconColor;

  /// [Color.withOpacity] value that should be used when the player is not in focus
  final double hiddenOpacity;

  /// [Container.decoration] for the region behind the controls
  final Decoration controlsBackground;

  /// [MainAxisAlignment] for where the controls should appear
  final MainAxisAlignment controlsAlignment;

  /// Play button visability
  final ButtonVis playVis;

  /// Volume button visability
  final ButtonVis volumeVis;

  /// Whether a volume slider is available
  /// If false, the volume will switch between [startingVolume] and off
  final bool variableVolume;

  /// Replay button visability
  final ButtonVis replayVis;

  /// Time/progress slider visability
  final ButtonVis sliderVis;

  /// Whether buttons set to [ButtonVis.auto] should show when the video is paused
  final bool showOnPause;

  final bool autoPlay;
  final bool autoLoop;
  final double startingVolume;

  /// [Stack]s control buttons on top of an [AspectRatio] for the [controller]
  /// Also supports tap-to-pause on the main window via [MouseRegion]
  /// The visibility of each button can be controlled with [ButtonVis]
  /// On mobile, [ButtonVis.auto] gets overidden to [ButtonVis.alwaysOn]
  /// Optionally provide a [BoxDecoration] background for the controls region
  /// The video will begin muted unless [startingVolume] is specified
  const EzVideoPlayer({
    Key? key,
    required this.controller,
    required this.semantics,
    required this.iconColor,
    this.hiddenOpacity = 0.0,
    this.controlsBackground = const BoxDecoration(color: Colors.transparent),
    this.controlsAlignment = MainAxisAlignment.center,
    this.playVis = ButtonVis.auto,
    this.volumeVis = ButtonVis.auto,
    this.variableVolume = true,
    this.replayVis = ButtonVis.auto,
    this.sliderVis = ButtonVis.auto,
    this.showOnPause = false,
    this.autoPlay = true,
    this.autoLoop = false,
    this.startingVolume = 0.0,
  }) : super(key: key);

  @override
  _EzVideoPlayerState createState() => _EzVideoPlayerState();
}

class _EzVideoPlayerState extends State<EzVideoPlayer> {
  // Gather theme data //
  bool show = false;
  bool checkedAutoPlay = false;
  bool autoPlayDisabled = false;

  double? savedVolume;
  double _currentPosition = 0.0;

  final double _margin = EzConfig.instance.prefs[marginKey];
  final double _padding = EzConfig.instance.prefs[paddingKey];
  final double _buttonSpacer = EzConfig.instance.prefs[buttonSpacingKey];
  final double _buttonSize = EzConfig.instance.prefs[circleDiameterKey] / 2;

  late final Color _showing = widget.iconColor;
  late final Color _hiding = (widget.hiddenOpacity == 0.0)
      ? Colors.transparent
      : widget.iconColor.withOpacity(widget.hiddenOpacity);

  // Define the functions //

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

  // Define the buttons //

  Color _buildColor(ButtonVis visibility) {
    switch (visibility) {
      case ButtonVis.alwaysOff:
        return Colors.transparent;
      case ButtonVis.alwaysOn:
        return _showing;
      case ButtonVis.auto:
        return (show || Platform.isAndroid || Platform.isIOS)
            ? _showing
            : (widget.showOnPause && !widget.controller.value.isPlaying)
                ? _showing
                : _hiding;
    }
  }

  List<Widget> _buildButtons(
    SliderThemeData sliderTheme,
    BuildContext context,
  ) {
    List<Widget> controls = [];

    // Play/pause
    if (widget.playVis != ButtonVis.alwaysOff) {
      controls.addAll([
        Semantics(
          button: true,
          hint: widget.controller.value.isPlaying
              ? EFUILang.of(context)!.gPause
              : EFUILang.of(context)!.gPlay,
          child: ExcludeSemantics(
            child: IconButton(
              icon: Icon((widget.controller.value.isPlaying)
                  ? PlatformIcons(context).pause
                  : PlatformIcons(context).playArrow),
              onPressed: () {
                (widget.controller.value.isPlaying)
                    ? _pauseVideo()
                    : _playVideo();
              },
              color: _buildColor(widget.playVis),
              iconSize: _buttonSize,
            ),
          ),
        ),
        EzSpacer.row(_buttonSpacer),
      ]);
    }

    // Volume
    if (widget.volumeVis != ButtonVis.alwaysOff) {
      controls.addAll([
        // Base button
        Semantics(
          button: true,
          hint: EFUILang.of(context)!.gMute,
          child: ExcludeSemantics(
            child: IconButton(
              icon: Icon((widget.controller.value.volume == 0.0)
                  ? PlatformIcons(context).volumeMute
                  : PlatformIcons(context).volumeUp),
              onPressed: () {
                (widget.controller.value.volume == 0.0)
                    ? _unMuteVideo()
                    : _muteVideo();
              },
              color: _buildColor(widget.volumeVis),
              iconSize: _buttonSize,
            ),
          ),
        ),

        (widget.variableVolume)
            ? EzSpacer.row(_padding)
            : EzSpacer.row(_buttonSpacer),
      ]);
    }

    if (widget.volumeVis != ButtonVis.alwaysOff && widget.variableVolume) {
      controls.addAll([
        // Value slider
        Container(
          height: _buttonSize,
          width: _buttonSize * 3.0,
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
        EzSpacer.row(_buttonSpacer),
      ]);
    }

    // Replay
    if (widget.replayVis != ButtonVis.alwaysOff) {
      controls.addAll([
        Semantics(
          button: true,
          hint: EFUILang.of(context)!.gReplay,
          child: ExcludeSemantics(
            child: IconButton(
              icon: Icon(PlatformIcons(context).refresh),
              onPressed: _replayVideo,
              color: _buildColor(widget.replayVis),
              iconSize: _buttonSize,
            ),
          ),
        ),
        EzSpacer.row(_buttonSpacer),
      ]);
    }

    return controls;
  }

  // Initialize the video //

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

    if (widget.autoPlay) {
      widget.controller.play();

      Future.delayed(Duration(milliseconds: 250), () {
        if (!checkedAutoPlay && !widget.controller.value.isPlaying) {
          setState(() {
            checkedAutoPlay = true;
            autoPlayDisabled = true;
          });
        } else {
          setState(() {
            checkedAutoPlay = true;
          });
        }
      });
    }
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    Color sliderColor = _buildColor(widget.sliderVis);

    SliderThemeData videoSliderTheme = Theme.of(context).sliderTheme.copyWith(
          thumbShape: (sliderColor == Colors.transparent)
              ? SliderComponentShape.noThumb
              : null,
          activeTrackColor: sliderColor,
          inactiveTrackColor: sliderColor,
          thumbColor: sliderColor,
        );

    return autoPlayDisabled
        ? EzWarning(message: EFUILang.of(context)!.gAutoPlayDisabled)
        : Semantics(
            label: widget.semantics,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
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
              child: AspectRatio(
                aspectRatio: widget.controller.value.aspectRatio,
                child: Stack(
                  children: [
                    // Video
                    VideoPlayer(widget.controller),

                    // Tap-to-pause
                    ExcludeSemantics(
                      child: Positioned(
                        top: 0,
                        bottom: _buttonSize * 3,
                        left: 0,
                        right: 0,
                        child: GestureDetector(
                            child: Container(color: Colors.transparent),
                            onTap: () {
                              (widget.controller.value.isPlaying)
                                  ? _pauseVideo()
                                  : _playVideo();
                            }),
                      ),
                    ),

                    // Controls
                    Positioned(
                      height: _buttonSize * 3,
                      bottom: 0,
                      left: _margin,
                      right: _margin,
                      child: Container(
                        decoration: widget.controlsBackground,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Time seeker
                            (widget.sliderVis != ButtonVis.alwaysOff)
                                ? SliderTheme(
                                    data: videoSliderTheme,
                                    child: Slider(
                                      value: _currentPosition,
                                      onChangeStart: (_) => _pauseVideo,
                                      onChanged: (double value) {
                                        setState(() {
                                          _currentPosition = value;
                                          widget.controller
                                              .seekTo(_findPoint(value));
                                        });
                                      },
                                    ),
                                  )
                                : EzSpacer(_buttonSize),

                            // Buttons
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: widget.controlsAlignment,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  _buildButtons(videoSliderTheme, context),
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
