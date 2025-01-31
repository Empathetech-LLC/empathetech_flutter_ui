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
  final Color timeTextColor;

  /// Playback speed selector visibility
  final EzButtonVis speedVis;

  /// Playback speed
  final double speed;

  /// Replay button visibility
  final EzButtonVis replayVis;

  /// Whether buttons set to [EzButtonVis.auto] should showControls when the video is paused
  final bool showOnPause;

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
    this.timeTextColor = Colors.white,
    this.speedVis = EzButtonVis.auto,
    this.speed = 1.0,
    this.replayVis = EzButtonVis.auto,
    this.showOnPause = false,
    this.autoPlay = true,
    this.autoLoop = false,
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
      widget.timeSliderVis == EzButtonVis.alwaysOff;

  late final double controlsHeight = noControls
      ? 0
      : (widget.timeSliderVis == EzButtonVis.alwaysOff)
          ? (2 * margin + iconSize + padding)
          : (3 * margin + 2 * (iconSize + padding));

  double? savedVolume;
  double currentPosition = 0.0;

  // Define custom functions //

  Future<void> play() => widget.controller.play();

  Future<void> pause() => widget.controller.pause();

  Future<void> mute() async {
    savedVolume = widget.controller.value.volume;
    await widget.controller.setVolume(0.0);
    setState(() {});
  }

  Future<void> unMute() => widget.controller.setVolume(savedVolume ?? 1.0);

  Future<void> replay() async {
    await widget.controller.pause();
    await widget.controller.seekTo(Duration.zero);
    await widget.controller.play();
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

    widget.controller.addListener(() => setState(
        () => currentPosition = pComplete(widget.controller.value.position)));

    if (widget.autoPlay) await play();
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
          fit: StackFit.passthrough,
          clipBehavior: Clip.none,
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
                  onTap: () async {
                    widget.controller.value.isPlaying
                        ? await pause()
                        : await play();
                  },
                ),
              ),
            ),

            // Controls
            Visibility(
              visible: showControls,
              child: Positioned(
                height: controlsHeight,
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: widget.controlsBackground,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Time seeker
                      Visibility(
                        visible: widget.timeSliderVis != EzButtonVis.alwaysOff,
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
                          const EzSpacer(vertical: false),

                          // Play/pause
                          Visibility(
                            visible: widget.playVis != EzButtonVis.alwaysOff,
                            child: Padding(
                              padding: EdgeInsets.only(right: spacing),
                              child: widget.controller.value.isPlaying
                                  ? EzIconButton(
                                      onPressed: pause,
                                      tooltip: l10n.gPause,
                                      color: iconColor,
                                      icon: Icon(PlatformIcons(context).pause),
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
                            visible: widget.volumeVis != EzButtonVis.alwaysOff,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: widget.variableVolume ? margin : spacing,
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
                                      icon:
                                          Icon(PlatformIcons(context).volumeUp),
                                    ),
                            ),
                          ),

                          // Volume slider
                          Visibility(
                            visible: (widget.variableVolume &&
                                widget.volumeVis != EzButtonVis.alwaysOff),
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

                          // Time label
                          Visibility(
                            visible:
                                widget.timeLabelVis != EzButtonVis.alwaysOff,
                            child: Padding(
                              padding: EdgeInsets.only(right: spacing),
                              child: Text(
                                '${ezVideoTime(widget.controller.value.position)} / ${ezVideoTime(widget.controller.value.duration)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(color: widget.timeTextColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),

                          // Playback speed selector
                          Visibility(
                            visible: widget.speedVis != EzButtonVis.alwaysOff,
                            child: Padding(
                              padding: EdgeInsets.only(right: spacing),
                              child: Tooltip(
                                message: l10n.gPlaybackSpeed,
                                child: EzDropdownMenu<double>(
                                  initialSelection: widget.speed,
                                  widthEntries: <String>['1.0'],
                                  dropdownMenuEntries: <double>[
                                    0.25,
                                    0.5,
                                    0.75,
                                    1.0,
                                    1.25,
                                    1.5,
                                    1.75,
                                    2.0,
                                  ]
                                      .map((double value) =>
                                          DropdownMenuEntry<double>(
                                            value: value,
                                            label: value.toString(),
                                          ))
                                      .toList(),
                                  enableSearch: false,
                                  requestFocusOnTap: true,
                                  onSelected: (double? value) => (value == null)
                                      ? doNothing
                                      : setState(() => widget.controller
                                          .setPlaybackSpeed(value)),
                                ),
                              ),
                            ),
                          ),

                          // Replay
                          Visibility(
                            visible: widget.replayVis != EzButtonVis.alwaysOff,
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: spacing),
                              child: EzIconButton(
                                onPressed: replay,
                                tooltip: l10n.gReplay,
                                color: iconColor,
                                icon: Icon(PlatformIcons(context).refresh),
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
