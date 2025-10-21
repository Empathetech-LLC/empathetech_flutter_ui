/* empathetech_flutter_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
// import 'package:go_transitions/go_transitions.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

enum EzButtonVis { alwaysOff, alwaysOn, auto }

class EzVideoPlayer extends StatefulWidget {
  /// [VideoPlayerController] passthrough
  final VideoPlayerController controller;

  /// [AspectRatio.aspectRatio] for the video
  final double aspectRatio;

  /// [BoxConstraints.maxHeight] for the video
  final double maxHeight;

  /// [BoxConstraints.maxWidth] for the video
  final double maxWidth;

  /// Defaults to [ColorScheme.surface]
  final Color? backgroundColor;

  /// [String] label for screen readers
  final String semantics;

  /// Whether the video has captions available
  final bool hasCaptions;

  /// Defaults to [ColorScheme.primary]
  final Color? iconColor;

  /// Defaults to [ColorScheme.secondary]
  final Color? sliderColor;

  /// Defaults to [textColor] with 50% opacity
  final Color? sliderBufferColor;

  /// Seconds to skip forward/backward on arrow key press
  final int skipTime = 10;

  /// [Color] for the controls region [Container.decoration]
  /// Defaults to black with 50% opacity -> 0x80000000
  final Color controlsBackground;

  /// Time/progress slider visibility
  final EzButtonVis timeSliderVis;

  /// Play button visibility
  final EzButtonVis playVis;

  /// Volume button visibility
  final EzButtonVis volumeVis;

  /// Whether a volume slider is available
  final bool variableVolume;

  /// Volume the video should begin with
  final double startingVolume;

  /// Time completed / total time visibility
  final EzButtonVis timeLabelVis;

  /// Defaults to [Colors.white]
  final Color textColor;

  /// Playback speed selector visibility
  final EzButtonVis speedVis;

  /// Playback speed
  final double speed;

  /// Fullscreen button visibility
  // final EzButtonVis fullScreenVis;

  /// Whether the video is in fullscreen mode
  /// Recommended to leave as false to start
  /// Navigating to the fullscreen page is made much simpler with this as a parameter
  // final bool isFullscreen;

  /// The platform the app is running on
  /// Recommended to use [getBasePlatform]
  // final TargetPlatform platform;

  /// Whether buttons set to [EzButtonVis.auto] should appear when the video is paused
  /// Only for desktop (and desktop Web), is always true for mobile (and mobile Web)
  final bool showOnPause;

  /// Amount of seconds the controls should show on mobile after user interaction
  final int mobileDelay;

  /// Whether the video should begin upon initialization
  final bool autoPlay;

  /// Whether the video should replay when complete
  final bool autoLoop;

  /// [Stack]s control buttons on top of a [VideoPlayer]
  /// Also supports tap-to-pause on the main window via [MouseRegion]
  /// The visibility of each button can be controlled with [EzButtonVis]
  /// The video will begin muted unless [startingVolume] is specified
  const EzVideoPlayer({
    super.key,
    required this.controller,
    required this.aspectRatio,
    required this.maxHeight,
    required this.maxWidth,
    this.backgroundColor,
    required this.semantics,
    this.hasCaptions = false,
    this.iconColor,
    this.sliderColor,
    this.sliderBufferColor,
    this.controlsBackground = const Color(0x80000000),
    this.timeSliderVis = EzButtonVis.auto,
    this.playVis = EzButtonVis.auto,
    this.volumeVis = EzButtonVis.auto,
    this.variableVolume = true,
    this.startingVolume = 0.0,
    this.timeLabelVis = EzButtonVis.auto,
    this.textColor = Colors.white,
    this.speedVis = EzButtonVis.auto,
    this.speed = 1.0,
    // this.fullScreenVis = EzButtonVis.auto,
    // this.isFullscreen = false,
    // required this.platform,
    this.showOnPause = false,
    this.mobileDelay = 3,
    this.autoPlay = true,
    this.autoLoop = false,
  });

  @override
  State<EzVideoPlayer> createState() => _EzVideoPlayerState();
}

class _EzVideoPlayerState extends State<EzVideoPlayer> {
  // Gather the fixed theme data //

  late final bool onMobile = isMobile();

  final double margin = EzConfig.get(marginKey);
  final double padding = EzConfig.get(paddingKey);
  final double spacing = EzConfig.get(spacingKey);
  final double iconSize = EzConfig.get(iconSizeKey);

  late final EFUILang l10n = ezL10n(context);

  // Define the build data //

  late final int videoLength = widget.controller.value.duration.inMilliseconds;
  bool hovering = false;
  Timer? mobileHover;

  late double currSpeed = widget.speed;

  double? savedVolume;
  Timer? showVolume;

  bool showCaptions = false;
  final MenuController subMenuControl = MenuController();
  int captionStyle = 1;

  late final bool persistentControls =
      widget.timeSliderVis == EzButtonVis.alwaysOn ||
          widget.playVis == EzButtonVis.alwaysOn ||
          widget.volumeVis == EzButtonVis.alwaysOn ||
          widget.timeLabelVis == EzButtonVis.alwaysOn ||
          widget.speedVis == EzButtonVis.alwaysOn;
  // || widget.fullScreenVis == EzButtonVis.alwaysOn;
  late final bool noControls = widget.timeSliderVis == EzButtonVis.alwaysOff &&
      widget.playVis == EzButtonVis.alwaysOff &&
      widget.volumeVis == EzButtonVis.alwaysOff &&
      widget.timeLabelVis == EzButtonVis.alwaysOff &&
      widget.speedVis == EzButtonVis.alwaysOff;
  // && widget.fullScreenVis == EzButtonVis.alwaysOff;

  late final double controlsHeight = noControls
      ? 0
      : (widget.timeSliderVis == EzButtonVis.alwaysOff)
          ? (2 * margin + iconSize + padding)
          : (3 * margin + 2 * (iconSize + padding));

  // Define custom functions //

  void handleMobileHover() {
    if (!onMobile) return;

    mobileHover?.cancel();
    if (!hovering) setState(() => hovering = true);

    mobileHover = Timer(
      Duration(seconds: widget.mobileDelay),
      () => setState(() => hovering = false),
    );
  }

  Future<void> play(VideoPlayerValue value) async {
    if (value.isCompleted) await widget.controller.seekTo(Duration.zero);
    await widget.controller.play();
    handleMobileHover();
  }

  Future<void> pause() async {
    await widget.controller.pause();
    handleMobileHover();
  }

  Future<void> mute(VideoPlayerValue value) async {
    savedVolume = value.volume;
    await widget.controller.setVolume(0.0);
    handleMobileHover();
  }

  Future<void> unMute() async {
    await widget.controller.setVolume(savedVolume ?? 1.0);
    handleMobileHover();
  }

  Future<void> skipForward(VideoPlayerValue value) => widget.controller
      .seekTo(value.position + Duration(seconds: widget.skipTime));

  Future<void> skipBackward(VideoPlayerValue value) => widget.controller
      .seekTo(value.position - Duration(seconds: widget.skipTime));

  /// Call [ezFullscreenToggle] and handle [Navigator] updates
  // Future<void> toggleFullscreen() async {
  //   await ezFullscreenToggle(widget.platform, widget.isFullscreen);
  //   if (!mounted) return;

  //   widget.isFullscreen
  //       ? Navigator.of(context).maybePop()
  //       : Navigator.of(context).push(
  //           GoTransitionRoute(
  //             transition: GoTransitions.zoom,
  //             builder: (_) => Scaffold(
  //               backgroundColor: Theme.of(context).colorScheme.surface,
  //               body: EzVideoPlayer(
  //                 controller: widget.controller,
  //                 aspectRatio: widget.aspectRatio,
  //                 maxHeight: double.infinity,
  //                 maxWidth: double.infinity,
  //                 backgroundColor: widget.backgroundColor,
  //                 semantics: widget.semantics,
  //                 hasCaptions: widget.hasCaptions,
  //                 iconColor: widget.iconColor,
  //                 sliderColor: widget.sliderColor,
  //                 sliderBufferColor: widget.sliderBufferColor,
  //                 controlsBackground: widget.controlsBackground,
  //                 timeSliderVis: widget.timeSliderVis,
  //                 playVis: widget.playVis,
  //                 volumeVis: widget.volumeVis,
  //                 variableVolume: widget.variableVolume,
  //                 startingVolume: value.volume,
  //                 timeLabelVis: widget.timeLabelVis,
  //                 textColor: widget.textColor,
  //                 speedVis: widget.speedVis,
  //                 speed: currSpeed,
  //                 fullScreenVis: widget.fullScreenVis,
  //                 isFullscreen: true,
  //                 platform: widget.platform,
  //                 showOnPause: widget.showOnPause,
  //                 mobileDelay: widget.mobileDelay,
  //                 autoPlay: false,
  //                 autoLoop: widget.autoLoop,
  //               ),
  //             ),
  //           ),
  //         );
  // }

  void showVolumeLabel() {
    showVolume?.cancel();
    showVolume = Timer(
      const Duration(milliseconds: 500),
      () => showVolume?.cancel(),
    );
  }

  bool showControl(EzButtonVis vis, bool isPlaying) {
    switch (vis) {
      case EzButtonVis.alwaysOn:
        return true;
      case EzButtonVis.alwaysOff:
        return false;
      case EzButtonVis.auto:
        if (hovering ||
            subMenuControl.isOpen ||
            ((onMobile || widget.showOnPause) && !isPlaying)) {
          return true;
        } else {
          return false;
        }
    }
  }

  /// Get the percent of the total video that is complete from the passed [Duration]
  double pComplete(Duration position) {
    return (position.isNegative || position.inMilliseconds == 0)
        ? 0
        : position.inMilliseconds / videoLength;
  }

  /// Get the [Duration] value that corresponds to the passed [completion]
  Duration findP(double completion) => completion >= 1
      ? Duration(milliseconds: videoLength)
      : Duration(milliseconds: (videoLength * completion).round());

  // Init //

  @override
  void initState() {
    super.initState();
    setupVideo();
  }

  Future<void> setupVideo() async {
    await widget.controller.setVolume(widget.startingVolume);
    await widget.controller.setPlaybackSpeed(widget.speed);
    await widget.controller.setLooping(widget.autoLoop);

    if (!widget.controller.value.isInitialized) {
      await widget.controller.initialize();
    }
    if (widget.autoPlay) await play(widget.controller.value);
  }

  @override
  Widget build(BuildContext context) {
    // Gather the dynamic theme data //

    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color iconColor = widget.iconColor ?? colorScheme.primary;

    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextStyle? labelStyle =
        textTheme.labelLarge?.copyWith(color: widget.textColor);

    final SliderThemeData sliderTheme = SliderThemeData(
      activeTrackColor: widget.sliderColor ?? colorScheme.secondary,
      inactiveTrackColor:
          widget.sliderBufferColor ?? widget.textColor.withValues(alpha: 0.5),
      thumbColor: iconColor,
    );

    // Return the build //

    return Semantics(
      label: widget.semantics,
      child: ValueListenableBuilder<VideoPlayerValue>(
        valueListenable: widget.controller,
        builder: (_, VideoPlayerValue value, __) => Focus(
          autofocus: true,
          onKeyEvent: (_, KeyEvent event) {
            if (event is KeyDownEvent) {
              switch (event.logicalKey) {
                // Up/Down -> volume control (if relevant)
                case LogicalKeyboardKey.arrowUp:
                  if (widget.variableVolume) {
                    double newVol = value.volume + 0.05;
                    if (newVol > 1.0) newVol = 1.0;

                    widget.controller.setVolume(newVol);
                    showVolumeLabel();
                  }
                  return KeyEventResult.handled;
                case LogicalKeyboardKey.arrowDown:
                  if (widget.variableVolume) {
                    double newVol = value.volume - 0.05;
                    if (newVol < 0.0) newVol = 0.0;

                    widget.controller.setVolume(newVol);
                    showVolumeLabel();
                  }
                  return KeyEventResult.handled;

                // Left/Right -> time skip
                case LogicalKeyboardKey.arrowRight:
                  skipForward(value);
                  return KeyEventResult.handled;
                case LogicalKeyboardKey.arrowLeft:
                  skipBackward(value);
                  return KeyEventResult.handled;

                // Space -> play/pause
                case LogicalKeyboardKey.space:
                  value.isPlaying ? pause() : play(value);
                  return KeyEventResult.handled;

                // C -> captions toggle (if relevant)
                case LogicalKeyboardKey.keyC:
                  if (widget.hasCaptions) {
                    setState(() => showCaptions = !showCaptions);
                    return KeyEventResult.handled;
                  } else {
                    return KeyEventResult.ignored;
                  }

                // // F -> fullscreen toggle
                // case LogicalKeyboardKey.keyF:
                //   toggleFullscreen();
                //   return KeyEventResult.handled;

                // // Esc -> exit fullscreen
                // case LogicalKeyboardKey.escape:
                //   if (widget.isFullscreen) {
                //     toggleFullscreen();
                //     return KeyEventResult.handled;
                //   } else {
                //     return KeyEventResult.ignored;
                //   }
                default:
                  return KeyEventResult.ignored;
              }
            }
            return KeyEventResult.ignored;
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (_) => setState(() => hovering = true),
            onExit: (_) => setState(() => hovering = false),
            child: Stack(
              fit: StackFit.passthrough,
              clipBehavior: Clip.none,
              children: <Widget>[
                // Video
                ExcludeSemantics(
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: widget.maxHeight,
                      maxWidth: widget.maxWidth,
                    ),
                    color: widget.backgroundColor ?? colorScheme.surface,
                    child: AspectRatio(
                      aspectRatio: widget.aspectRatio,
                      child: VideoPlayer(widget.controller),
                    ),
                  ),
                ),

                // Volume label (shows on arrow up/down)
                Positioned(
                  left: 0,
                  right: 0,
                  top: spacing * 2,
                  child: Visibility(
                    visible: showVolume?.isActive == true,
                    child: ExcludeSemantics(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // Row seems weird, but it prevents the Text from auto-expanding
                          EzText(
                            '${(value.volume * 100).toStringAsFixed(0)}%',
                            style: switch (captionStyle) {
                              4 => textTheme.displayLarge
                                  ?.copyWith(color: widget.textColor),
                              3 => textTheme.headlineLarge
                                  ?.copyWith(color: widget.textColor),
                              2 => textTheme.titleLarge
                                  ?.copyWith(color: widget.textColor),
                              1 => textTheme.bodyLarge
                                  ?.copyWith(color: widget.textColor),
                              _ => labelStyle,
                            },
                            textAlign: TextAlign.center,
                            backgroundColor: widget.controlsBackground,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Layer for taps, gestures, and key events
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: controlsHeight,
                  child: ExcludeSemantics(
                    child: GestureDetector(
                      onTap: () async {
                        if (onMobile) {
                          mobileHover?.cancel();

                          hovering
                              ? setState(() => hovering = false)
                              : handleMobileHover();
                        } else {
                          value.isPlaying ? await pause() : await play(value);
                        }
                      },
                      onDoubleTapDown: (TapDownDetails tap) async {
                        final RenderBox mySpace =
                            context.findRenderObject() as RenderBox;

                        (tap.localPosition.dx < mySpace.size.width / 2)
                            ? await skipBackward(value)
                            : await skipForward(value);
                      },
                      child: Container(
                        color: Colors.transparent,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),

                // Captions
                if (showCaptions)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: (persistentControls ||
                            hovering ||
                            subMenuControl.isOpen)
                        ? controlsHeight
                        : margin,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // Row seems weird, but it prevents the Text from auto-expanding
                        ExcludeSemantics(
                          child: EzText(
                            value.caption.text,
                            style: switch (captionStyle) {
                              4 => textTheme.displayLarge
                                  ?.copyWith(color: widget.textColor),
                              3 => textTheme.headlineLarge
                                  ?.copyWith(color: widget.textColor),
                              2 => textTheme.titleLarge
                                  ?.copyWith(color: widget.textColor),
                              1 => textTheme.bodyLarge
                                  ?.copyWith(color: widget.textColor),
                              _ => labelStyle,
                            },
                            textAlign: TextAlign.center,
                            backgroundColor: widget.controlsBackground,
                          ),
                        ),
                      ],
                    ),
                  ),

                // Middle play button
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Visibility(
                    visible: (onMobile && hovering) ||
                        (!value.isPlaying &&
                            (value.isCompleted ||
                                value.position.inSeconds < 1)),
                    child: ExcludeSemantics(
                      child: Center(
                        child: value.isPlaying
                            ? EzIconButton(
                                onPressed: pause,
                                color: iconColor,
                                icon: Icon(PlatformIcons(context).pause),
                              )
                            : EzIconButton(
                                onPressed: () => play(value),
                                color: iconColor,
                                icon: Icon(value.isCompleted
                                    ? Icons.replay
                                    : PlatformIcons(context).playArrow),
                              ),
                      ),
                    ),
                  ),
                ),

                // Controls
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  height: controlsHeight,
                  child: Visibility(
                    visible:
                        persistentControls || hovering || subMenuControl.isOpen,
                    child: Container(
                      decoration:
                          BoxDecoration(color: widget.controlsBackground),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Time seeker
                          Visibility(
                            visible: showControl(
                                widget.timeSliderVis, value.isPlaying),
                            child: SizedBox(
                              height: iconSize,
                              width: double.infinity,
                              child: SliderTheme(
                                data: sliderTheme,
                                child: Slider(
                                  value: pComplete(value.position),
                                  onChangeStart: (_) async {
                                    await pause();
                                    if (onMobile) mobileHover?.cancel();
                                  },
                                  onChanged: (double value) =>
                                      widget.controller.seekTo(findP(value)),
                                  onChangeEnd: (_) async {
                                    await play(value);
                                    handleMobileHover();
                                  },
                                ),
                              ),
                            ),
                          ),
                          ezMargin,

                          // Buttons
                          NotificationListener<ScrollNotification>(
                            onNotification: (_) {
                              handleMobileHover();
                              return false;
                            },
                            child: EzScrollView(
                              scrollDirection: Axis.horizontal,
                              showScrollHint: true,
                              children: <Widget>[
                                ezRowSpacer,

                                // Play/pause
                                Visibility(
                                  visible: showControl(
                                      widget.playVis, value.isPlaying),
                                  child: Padding(
                                    padding: EdgeInsets.only(right: spacing),
                                    child: value.isPlaying
                                        ? EzIconButton(
                                            onPressed: pause,
                                            tooltip: l10n.gPause,
                                            color: iconColor,
                                            icon: Icon(
                                                PlatformIcons(context).pause),
                                          )
                                        : EzIconButton(
                                            onPressed: () => play(value),
                                            tooltip: l10n.gPlay,
                                            color: iconColor,
                                            icon: Icon(value.isCompleted
                                                ? Icons.replay
                                                : PlatformIcons(context)
                                                    .playArrow),
                                          ),
                                  ),
                                ),

                                // Volume toggle
                                Visibility(
                                  visible: showControl(
                                      widget.volumeVis, value.isPlaying),
                                  child: Padding(
                                    padding: widget.variableVolume
                                        ? EdgeInsets.zero
                                        : EdgeInsets.only(right: spacing),
                                    child: (value.volume == 0.0)
                                        ? EzIconButton(
                                            onPressed: unMute,
                                            tooltip: l10n.gUnMute,
                                            color: iconColor,
                                            icon: Icon(PlatformIcons(context)
                                                .volumeMute),
                                          )
                                        : EzIconButton(
                                            onPressed: () => mute(value),
                                            tooltip: l10n.gMute,
                                            color: iconColor,
                                            icon: Icon(PlatformIcons(context)
                                                .volumeUp),
                                          ),
                                  ),
                                ),

                                // Volume slider
                                Visibility(
                                  visible: (widget.variableVolume &&
                                      showControl(
                                          widget.volumeVis, value.isPlaying)),
                                  child: Padding(
                                    padding: EdgeInsets.only(right: spacing),
                                    child: SizedBox(
                                      height: iconSize,
                                      width: 100,
                                      child: SliderTheme(
                                        data: sliderTheme,
                                        child: Slider(
                                          value: value.volume,
                                          onChangeStart: (_) {
                                            if (onMobile) mobileHover?.cancel();
                                          },
                                          onChanged: (double value) => widget
                                              .controller
                                              .setVolume(value),
                                          onChangeEnd: (_) =>
                                              handleMobileHover(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // Time label
                                Visibility(
                                  visible: showControl(
                                      widget.timeLabelVis, value.isPlaying),
                                  child: Padding(
                                    padding: EdgeInsets.only(right: spacing),
                                    child: Text(
                                      '${ezVideoTime(value.position)} / ${ezVideoTime(value.duration)}',
                                      style: labelStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),

                                // Playback speed selector
                                Visibility(
                                  visible: showControl(
                                      widget.speedVis, value.isPlaying),
                                  child: Padding(
                                    padding: EdgeInsets.only(right: spacing),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        EzIconButton(
                                          enabled: currSpeed > 0.25,
                                          onPressed: () async {
                                            setState(() => currSpeed -= 0.25);
                                            await widget.controller
                                                .setPlaybackSpeed(currSpeed);
                                            handleMobileHover();
                                          },
                                          tooltip:
                                              '${l10n.gDecrease} ${l10n.gPlaybackSpeed.toLowerCase()}',
                                          icon: Icon(
                                              PlatformIcons(context).remove),
                                        ),
                                        ezRowMargin,
                                        Tooltip(
                                          message: l10n.gPlaybackSpeed,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.speed,
                                                size:
                                                    EzConfig.get(iconSizeKey) *
                                                        0.667,
                                                color: widget.textColor,
                                              ),
                                              Text(
                                                currSpeed.toStringAsFixed(2),
                                                style: labelStyle,
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                        ezRowMargin,
                                        EzIconButton(
                                          enabled: currSpeed < 2.0,
                                          onPressed: () async {
                                            setState(() => currSpeed += 0.25);
                                            await widget.controller
                                                .setPlaybackSpeed(currSpeed);
                                            handleMobileHover();
                                          },
                                          tooltip:
                                              '${l10n.gIncrease} ${l10n.gPlaybackSpeed.toLowerCase()}',
                                          icon:
                                              Icon(PlatformIcons(context).add),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // Captions
                                Visibility(
                                  visible: widget.hasCaptions &&
                                      showControl(
                                          EzButtonVis.auto, value.isPlaying),
                                  child: Padding(
                                    padding: EdgeInsets.only(right: spacing),
                                    child: MenuAnchor(
                                      controller: subMenuControl,
                                      builder: (_, __, ___) => EzIconButton(
                                        onPressed: () => subMenuControl.isOpen
                                            ? subMenuControl.close()
                                            : setState(() =>
                                                showCaptions = !showCaptions),
                                        onLongPress: () => subMenuControl.isOpen
                                            ? subMenuControl.close()
                                            : subMenuControl.open(),
                                        tooltip:
                                            '${l10n.gCaptions}\n${l10n.gCaptionsHint}',
                                        color: showCaptions
                                            ? iconColor
                                            : colorScheme.outline,
                                        icon: const Icon(Icons.subtitles),
                                      ),
                                      menuChildren: <Widget>[
                                        EzMenuButton(
                                          label: l10n.tsDisplay,
                                          textStyle: textTheme.displayLarge,
                                          textAlign: TextAlign.center,
                                          onPressed: () =>
                                              setState(() => captionStyle = 4),
                                        ),
                                        EzMenuButton(
                                          label: l10n.tsHeadline,
                                          textStyle: textTheme.headlineLarge,
                                          textAlign: TextAlign.center,
                                          onPressed: () =>
                                              setState(() => captionStyle = 3),
                                        ),
                                        EzMenuButton(
                                          label: l10n.tsTitle,
                                          textStyle: textTheme.titleLarge,
                                          textAlign: TextAlign.center,
                                          onPressed: () =>
                                              setState(() => captionStyle = 2),
                                        ),
                                        EzMenuButton(
                                          label: l10n.tsBody,
                                          textStyle: textTheme.bodyLarge,
                                          textAlign: TextAlign.center,
                                          onPressed: () =>
                                              setState(() => captionStyle = 1),
                                        ),
                                        EzMenuButton(
                                          label: l10n.tsLabel,
                                          textStyle: textTheme.labelLarge,
                                          textAlign: TextAlign.center,
                                          onPressed: () =>
                                              setState(() => captionStyle = 0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // // Fullscreen
                                // Visibility(
                                //   visible: showControl(widget.fullScreenVis),
                                //   child: Padding(
                                //     padding: EdgeInsets.only(right: spacing),
                                //     child: EzIconButton(
                                //       onPressed: toggleFullscreen,
                                //       tooltip: l10n.gFullScreen,
                                //       color: iconColor,
                                //       icon: Icon(widget.isFullscreen
                                //           ? PlatformIcons(context).fullscreenExit
                                //           : PlatformIcons(context).fullscreen),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const int _milisPerSec = 1000;
const int _milisPerMin = 60000;
const int _milisPerHour = 3600000;

String _tooTwo(int n) => n.toString().padLeft(2, '0');

/// Format [duration] into a video time format
/// Defaults to 'mm:ss', and will adapt to 'hh:mm:ss' if necessary
/// Optionally [showMili]
String ezVideoTime(Duration duration, {bool showMili = false}) {
  int miliSecs = duration.inMilliseconds;

  final int hours = ((miliSecs as double) / (_milisPerHour as double)).floor();
  final String hourS = _tooTwo(hours);

  miliSecs -= (hours * _milisPerHour);

  final int minutes = ((miliSecs as double) / (_milisPerMin as double)).floor();
  final String minS = _tooTwo(minutes);

  miliSecs -= (minutes * _milisPerMin);

  final int seconds = ((miliSecs as double) / (_milisPerSec as double)).floor();
  final String secS = _tooTwo(seconds);

  miliSecs -= (seconds * _milisPerSec);
  final String miliS = showMili ? ':${_tooTwo(miliSecs)}' : '';

  return hours > 0 ? '$hourS:$minS:$secS$miliS' : '$minS:$secS$miliS';
}
