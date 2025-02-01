/* empathetech_flutter_ui
 * Copyright (c) 2022-2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import '../../../empathetech_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
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

  /// Defaults to [ColorScheme.primary]
  final Color? iconColor;

  /// Defaults to [ColorScheme.secondary]
  final Color? sliderColor;

  /// Defaults to [ColorScheme.outline]
  final Color? sliderBufferColor;

  /// Seconds to skip forward/backward on arrow key press
  final int skipTime = 10;

  /// [Container.decoration] for the region behind the controls
  final Decoration controlsBackground;

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
  /// Not currently working... feel free to fix it :)
  final EzButtonVis fullScreenVis;

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
    this.iconColor,
    this.sliderColor,
    this.sliderBufferColor,
    this.controlsBackground = const BoxDecoration(color: Colors.transparent),
    this.timeSliderVis = EzButtonVis.auto,
    this.playVis = EzButtonVis.auto,
    this.volumeVis = EzButtonVis.auto,
    this.variableVolume = true,
    this.startingVolume = 0.0,
    this.timeLabelVis = EzButtonVis.auto,
    this.textColor = Colors.white,
    this.speedVis = EzButtonVis.auto,
    this.speed = 1.0,
    this.fullScreenVis = EzButtonVis.alwaysOff,
    this.showOnPause = false,
    this.mobileDelay = 3,
    this.autoPlay = true,
    this.autoLoop = false,
  });

  @override
  State<EzVideoPlayer> createState() => _EzVideoPlayerState();
}

class _EzVideoPlayerState extends State<EzVideoPlayer> {
  // Gather the theme data //

  late final TargetPlatform platform = getBasePlatform(context);
  late final bool isMobile =
      platform == TargetPlatform.iOS || platform == TargetPlatform.android;

  final EzSpacer ezMargin = EzMargin();
  final EzSpacer pmSpacer = EzMargin(vertical: false);

  final double margin = EzConfig.get(marginKey);
  final double padding = EzConfig.get(paddingKey);
  final double spacing = EzConfig.get(spacingKey);

  late final ColorScheme colorScheme = Theme.of(context).colorScheme;

  late final Color iconColor = widget.iconColor ?? colorScheme.primary;
  final double iconSize = EzConfig.get(iconSizeKey);

  late final SliderThemeData sliderTheme = SliderThemeData(
    activeTrackColor: widget.sliderColor ?? colorScheme.secondary,
    inactiveTrackColor: widget.sliderBufferColor ?? colorScheme.outline,
    thumbColor: iconColor,
  );

  late final EFUILang l10n = EFUILang.of(context)!;

  late final TextStyle? labelStyle =
      Theme.of(context).textTheme.labelLarge?.copyWith(color: widget.textColor);

  // Define the build data //

  double currPos = 0.0;
  double? savedVolume;
  late double currSpeed = widget.speed;
  bool fullScreen = false;

  bool hovering = false;

  late final bool persistentControls = isMobile ||
      widget.playVis == EzButtonVis.alwaysOn ||
      widget.volumeVis == EzButtonVis.alwaysOn ||
      widget.timeSliderVis == EzButtonVis.alwaysOn;
  late final bool noControls = widget.playVis == EzButtonVis.alwaysOff &&
      widget.volumeVis == EzButtonVis.alwaysOff &&
      widget.timeSliderVis == EzButtonVis.alwaysOff;

  late final double controlsHeight = noControls
      ? 0
      : (widget.timeSliderVis == EzButtonVis.alwaysOff)
          ? (2 * margin + iconSize + padding)
          : (3 * margin + 2 * (iconSize + padding));

  // Define custom functions //

  Future<void> play() async {
    if (isMobile) setState(() => hovering = true);

    if (widget.controller.value.isCompleted) {
      await widget.controller.seekTo(Duration.zero);
      await widget.controller.play();
    } else {
      await widget.controller.play();
    }

    if (isMobile) {
      Future<void>.delayed(
        Duration(seconds: widget.mobileDelay),
        () => setState(() => hovering = false),
      );
    }
  }

  Future<void> pause() async {
    if (isMobile) setState(() => hovering = true);

    await widget.controller.pause();

    if (isMobile) {
      Future<void>.delayed(
        Duration(seconds: widget.mobileDelay),
        () => setState(() => hovering = false),
      );
    }
  }

  Future<void> mute() async {
    savedVolume = widget.controller.value.volume;
    await widget.controller.setVolume(0.0);
    setState(() {});
  }

  Future<void> unMute() => widget.controller.setVolume(savedVolume ?? 1.0);

  Future<void> skipForward() => widget.controller.seekTo(
      widget.controller.value.position + Duration(seconds: widget.skipTime));

  Future<void> skipBackward() => widget.controller.seekTo(
      widget.controller.value.position - Duration(seconds: widget.skipTime));

  Future<void> toggleFullscreen() async {
    fullScreen = !fullScreen;
    fullScreen
        ? await SystemChrome.setEnabledSystemUIMode(
            SystemUiMode.immersiveSticky)
        : await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    setState(() {});
  }

  bool showControl(EzButtonVis vis) {
    switch (vis) {
      case EzButtonVis.alwaysOn:
        return true;
      case EzButtonVis.alwaysOff:
        return false;
      case EzButtonVis.auto:
        if (hovering ||
            ((isMobile || widget.showOnPause) &&
                !widget.controller.value.isPlaying)) {
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
    await widget.controller.setPlaybackSpeed(widget.speed);
    await widget.controller.setLooping(widget.autoLoop);

    if (!widget.controller.value.isInitialized) {
      await widget.controller.initialize();
    }

    widget.controller.addListener(() =>
        setState(() => currPos = pComplete(widget.controller.value.position)));

    if (widget.autoPlay) await play();
  }

  // Return the build //

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.semantics,
      child: Focus(
        autofocus: true,
        onKeyEvent: (FocusNode node, KeyEvent event) {
          if (event is KeyDownEvent) {
            switch (event.logicalKey) {
              case LogicalKeyboardKey.arrowRight:
                skipForward();
                return KeyEventResult.handled;
              case LogicalKeyboardKey.arrowLeft:
                skipBackward();
                return KeyEventResult.handled;
              case LogicalKeyboardKey.space:
                widget.controller.value.isPlaying ? pause() : play();
                return KeyEventResult.handled;
              case LogicalKeyboardKey.escape:
                if (fullScreen) {
                  toggleFullscreen();
                  return KeyEventResult.handled;
                } else {
                  return KeyEventResult.ignored;
                }
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
              Container(
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

              // Tap-to-pause
              Positioned(
                top: 0,
                bottom: controlsHeight,
                left: 0,
                right: 0,
                child: ExcludeSemantics(
                  child: GestureDetector(
                    onTap: () async {
                      widget.controller.value.isPlaying
                          ? await pause()
                          : await play();
                    },
                    onDoubleTapDown: (TapDownDetails tap) async {
                      final RenderBox mySpace =
                          context.findRenderObject() as RenderBox;

                      (tap.localPosition.dx < mySpace.size.width / 2)
                          ? await skipBackward()
                          : await skipForward();
                    },
                    child: Container(color: Colors.transparent),
                  ),
                ),
              ),

              // Controls
              Positioned(
                height: controlsHeight,
                bottom: 0,
                left: 0,
                right: 0,
                child: Visibility(
                  visible: persistentControls || hovering,
                  child: Container(
                    decoration: widget.controlsBackground,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Time seeker
                        Visibility(
                          visible: showControl(widget.timeSliderVis),
                          child: SizedBox(
                            height: iconSize,
                            width: double.infinity,
                            child: SliderTheme(
                              data: sliderTheme,
                              child: Slider(
                                value: currPos,
                                onChangeStart: (_) => pause,
                                onChanged: (double value) => setState(() {
                                  currPos = value;
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
                            const EzSpacer(vertical: false),

                            // Play/pause
                            Visibility(
                              visible: showControl(widget.playVis),
                              child: Padding(
                                padding: EdgeInsets.only(right: spacing),
                                child: widget.controller.value.isPlaying
                                    ? EzIconButton(
                                        onPressed: pause,
                                        tooltip: l10n.gPause,
                                        color: iconColor,
                                        icon:
                                            Icon(PlatformIcons(context).pause),
                                      )
                                    : EzIconButton(
                                        onPressed: play,
                                        tooltip: l10n.gPlay,
                                        color: iconColor,
                                        icon: Icon(
                                            PlatformIcons(context).playArrow),
                                      ),
                              ),
                            ),

                            // Volume toggle
                            Visibility(
                              visible: showControl(widget.volumeVis),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right:
                                      widget.variableVolume ? margin : spacing,
                                ),
                                child: (widget.controller.value.volume == 0.0)
                                    ? EzIconButton(
                                        onPressed: unMute,
                                        tooltip: l10n.gUnMute,
                                        color: iconColor,
                                        icon: Icon(
                                            PlatformIcons(context).volumeMute),
                                      )
                                    : EzIconButton(
                                        onPressed: mute,
                                        tooltip: l10n.gMute,
                                        color: iconColor,
                                        icon: Icon(
                                            PlatformIcons(context).volumeUp),
                                      ),
                              ),
                            ),

                            // Volume slider
                            Visibility(
                              visible: (widget.variableVolume &&
                                  showControl(widget.volumeVis)),
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
                                        () =>
                                            widget.controller.setVolume(value),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Time label
                            Visibility(
                              visible: showControl(widget.timeLabelVis),
                              child: Padding(
                                padding: EdgeInsets.only(right: spacing),
                                child: Text(
                                  '${ezVideoTime(widget.controller.value.position)} / ${ezVideoTime(widget.controller.value.duration)}',
                                  style: labelStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),

                            // Playback speed selector
                            Visibility(
                              visible: showControl(widget.speedVis),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: spacing,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    EzIconButton(
                                      enabled: currSpeed > 0.25,
                                      onPressed: () async {
                                        setState(() => currSpeed -= 0.25);
                                        await widget.controller
                                            .setPlaybackSpeed(currSpeed);
                                      },
                                      tooltip:
                                          '${l10n.gDecrease} ${l10n.gPlaybackSpeed.toLowerCase()}',
                                      icon: Icon(PlatformIcons(context).remove),
                                    ),
                                    pmSpacer,
                                    Tooltip(
                                      message: l10n.gPlaybackSpeed,
                                      child: Text(
                                        currSpeed.toStringAsFixed(2),
                                        style: labelStyle,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    pmSpacer,
                                    EzIconButton(
                                      enabled: currSpeed < 2.0,
                                      onPressed: () async {
                                        setState(() => currSpeed += 0.25);
                                        await widget.controller
                                            .setPlaybackSpeed(currSpeed);
                                      },
                                      tooltip:
                                          '${l10n.gIncrease} ${l10n.gPlaybackSpeed.toLowerCase()}',
                                      icon: Icon(PlatformIcons(context).add),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Fullscreen
                            Visibility(
                              visible: showControl(widget.fullScreenVis),
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: spacing),
                                child: EzIconButton(
                                  onPressed: toggleFullscreen,
                                  tooltip: l10n.gFullScreen,
                                  color: iconColor,
                                  icon: Icon(fullScreen
                                      ? PlatformIcons(context).fullscreenExit
                                      : PlatformIcons(context).fullscreen),
                                ),
                              ),
                            ),
                          ],
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
