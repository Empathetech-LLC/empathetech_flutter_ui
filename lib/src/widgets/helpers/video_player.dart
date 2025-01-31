/* empathetech_flutter_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

enum EzButtonVis { alwaysOff, alwaysOn, auto }

class EzVideoPlayer extends StatefulWidget {
  /// [VideoPlayerController] passthrough
  final VideoPlayerController controller;

  /// [String] label for screen readers
  final String semantics;

  /// Defaults to [ColorScheme.primary]
  final Color? iconColor;

  /// Defaults to [ColorScheme.secondary]
  final Color? sliderColor;

  /// Defaults to [ColorScheme.outline]
  final Color? sliderBufferColor;

  /// [Container.decoration] for the region behind the controls
  final Decoration controlsBackground;

  /// Play button visibility
  final EzButtonVis playVis;

  /// Volume button visibility
  final EzButtonVis volumeVis;

  /// Whether a volume slider is available
  final bool variableVolume;

  /// Replay button visibility
  final EzButtonVis replayVis;

  /// Time/progress slider visibility
  final EzButtonVis sliderVis;

  /// Whether buttons set to [EzButtonVis.auto] should showControls when the video is paused
  final bool showOnPause;

  /// Whether the video should begin upon initialization
  final bool autoPlay;

  /// Whether the video should replay when complete
  final bool autoLoop;

  /// Volume the video should begin with
  final double startingVolume;

  /// [Stack]s control buttons on top of a [VideoPlayer]
  /// Also supports tap-to-pause on the main window via [MouseRegion]
  /// The visibility of each button can be controlled with [EzButtonVis]
  /// The video will begin muted unless [startingVolume] is specified
  const EzVideoPlayer({
    super.key,
    required this.controller,
    required this.semantics,
    this.iconColor,
    this.sliderColor,
    this.sliderBufferColor,
    this.controlsBackground = const BoxDecoration(color: Colors.transparent),
    this.playVis = EzButtonVis.auto,
    this.volumeVis = EzButtonVis.auto,
    this.variableVolume = true,
    this.replayVis = EzButtonVis.auto,
    this.sliderVis = EzButtonVis.auto,
    this.showOnPause = false,
    this.autoPlay = true,
    this.autoLoop = false,
    this.startingVolume = 0.0,
  });

  @override
  State<EzVideoPlayer> createState() => _EzVideoPlayerState();
}

class _EzVideoPlayerState extends State<EzVideoPlayer> {
  // Gather the theme data //

  final EzSpacer ezMargin = EzMargin();

  final double margin = EzConfig.get(marginKey);
  final double padding = EzConfig.get(paddingKey);
  final double spacing = EzConfig.get(spacingKey);

  final double iconSize = EzConfig.get(iconSizeKey);

  late final ColorScheme colorScheme = Theme.of(context).colorScheme;

  late final Color iconColor = widget.iconColor ?? colorScheme.primary;

  late final SliderThemeData sliderTheme = SliderThemeData(
    activeTrackColor: widget.sliderColor ?? colorScheme.secondary,
    inactiveTrackColor: widget.sliderBufferColor ?? colorScheme.outline,
    thumbColor: iconColor,
  );

  late final EFUILang l10n = EFUILang.of(context)!;

  // Define the build data //

  bool showControls = false;
  late final bool noControls = widget.playVis == EzButtonVis.alwaysOff &&
      widget.volumeVis == EzButtonVis.alwaysOff &&
      widget.replayVis == EzButtonVis.alwaysOff &&
      widget.sliderVis == EzButtonVis.alwaysOff;

  late final double controlsHeight = noControls
      ? 0
      : (widget.sliderVis == EzButtonVis.alwaysOff)
          ? (2 * margin + iconSize + padding)
          : (3 * margin + 2 * (iconSize + padding));

  double? savedVolume;
  double currentPosition = 0.0;

  // Define custom functions //

  void play() => setState(() => widget.controller.play());

  void pause() => setState(() => widget.controller.pause());

  void mute() => setState(() {
        savedVolume = widget.controller.value.volume;
        widget.controller.setVolume(0.0);
      });

  void unMute() =>
      setState(() => widget.controller.setVolume(savedVolume ?? 1.0));

  void replay() => setState(() {
        widget.controller.pause();
        widget.controller.seekTo(Duration.zero);
        widget.controller.play();
      });

  /// Get the percent of the total video that is complete from the passed [Duration]
  double pComplete(Duration position) {
    return (position.isNegative || position.inMilliseconds == 0)
        ? 0
        : position.inMilliseconds /
            widget.controller.value.duration.inMilliseconds;
  }

  /// Get the [Duration] value that corresponds to the passed [completion]
  Duration findP(double completion) => completion >= 1
      ? Duration(milliseconds: widget.controller.value.duration.inMilliseconds)
      : Duration(
          milliseconds:
              (widget.controller.value.duration.inMilliseconds * completion)
                  .round());

  // Init //

  @override
  void initState() {
    super.initState();
    setupVideo();
  }

  Future<void> setupVideo() async {
    await widget.controller.setVolume(widget.startingVolume);

    // It seems that when autoLoop is false, the asset can sometimes be unloaded
    // Personally, (autoLoop == false) != (being able to play again at all == false)
    // So, we add this workaround
    await widget.controller.setLooping(true);

    widget.controller.addListener(() {
      currentPosition = pComplete(widget.controller.value.position);
      if (!widget.autoLoop && currentPosition >= 0.99) pause();
      setState(() {});
    });

    if (!widget.controller.value.isInitialized) {
      await widget.controller.initialize();
    }

    if (widget.autoPlay) play();
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semantics,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => showControls = true),
        onExit: (_) => setState(() => showControls = false),
        child: Stack(
          children: <Widget>[
            // Video
            Positioned.fill(child: VideoPlayer(widget.controller)),

            // Tap-to-pause
            Positioned(
              top: 0,
              bottom: controlsHeight,
              left: 0,
              right: 0,
              child: ExcludeSemantics(
                child: GestureDetector(
                  child: Container(color: Colors.transparent),
                  onTap: () =>
                      (widget.controller.value.isPlaying) ? pause() : play(),
                ),
              ),
            ),

            // Controls
            Visibility(
              visible: showControls,
              child: Positioned(
                height: controlsHeight,
                bottom: 0,
                left: margin / 2,
                right: margin / 2,
                child: Container(
                  decoration: widget.controlsBackground,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Time seeker
                      Visibility(
                        visible: widget.sliderVis != EzButtonVis.alwaysOff,
                        child: SizedBox(
                          height: iconSize,
                          width: double.infinity,
                          child: SliderTheme(
                            data: sliderTheme,
                            child: Slider(
                              value: currentPosition,
                              onChangeStart: (_) => pause,
                              onChanged: (double value) => setState(() {
                                currentPosition = value;
                                widget.controller.seekTo(findP(value));
                              }),
                            ),
                          ),
                        ),
                      ),
                      ezMargin,

                      // Buttons
                      EzScrollView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          ezMargin,

                          // Play/pause
                          Visibility(
                            visible: widget.playVis != EzButtonVis.alwaysOff,
                            child: Padding(
                              padding: EdgeInsets.only(right: spacing),
                              child: widget.controller.value.isPlaying
                                  ? Semantics(
                                      button: true,
                                      hint: l10n.gPause,
                                      child: ExcludeSemantics(
                                        child: EzIconButton(
                                          onPressed: pause,
                                          color: iconColor,
                                          icon: EzIcon(
                                            PlatformIcons(context).pause,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Semantics(
                                      button: true,
                                      hint: l10n.gPlay,
                                      child: ExcludeSemantics(
                                        child: EzIconButton(
                                          onPressed: play,
                                          color: iconColor,
                                          icon: EzIcon(
                                            PlatformIcons(context).playArrow,
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ),

                          // Volume toggle
                          Visibility(
                            visible: widget.volumeVis != EzButtonVis.alwaysOff,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: widget.variableVolume ? margin : spacing,
                              ),
                              child: Semantics(
                                button: true,
                                hint: EFUILang.of(context)!.gMute,
                                child: ExcludeSemantics(
                                  child: (widget.controller.value.volume == 0.0)
                                      ? EzIconButton(
                                          onPressed: unMute,
                                          color: iconColor,
                                          icon: EzIcon(
                                            PlatformIcons(context).volumeMute,
                                          ),
                                        )
                                      : EzIconButton(
                                          onPressed: mute,
                                          color: iconColor,
                                          icon: EzIcon(
                                            PlatformIcons(context).volumeUp,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),

                          // Volume slider
                          Visibility(
                            visible: widget.volumeVis != EzButtonVis.alwaysOff,
                            child: Padding(
                              padding: EdgeInsets.only(right: spacing),
                              child: SizedBox(
                                height: iconSize,
                                width: spacing * 2.0,
                                child: SliderTheme(
                                  data: sliderTheme,
                                  child: Slider(
                                    value: widget.controller.value.volume,
                                    onChanged: (double value) => setState(
                                      () => widget.controller.setVolume(value),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Replay
                          Visibility(
                            visible: widget.replayVis != EzButtonVis.alwaysOff,
                            child: Padding(
                              padding: EdgeInsets.only(right: spacing),
                              child: Semantics(
                                button: true,
                                hint: EFUILang.of(context)!.gReplay,
                                child: ExcludeSemantics(
                                  child: EzIconButton(
                                    icon:
                                        EzIcon(PlatformIcons(context).refresh),
                                    onPressed: replay,
                                    color: iconColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ezMargin,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
