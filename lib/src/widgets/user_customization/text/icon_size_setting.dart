/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class EzIconSizeSetting extends StatefulWidget {
  /// Set to false when using this outside of [EzTextSettings]
  final bool fullCheck;

  const EzIconSizeSetting({super.key, this.fullCheck = true});

  @override
  State<EzIconSizeSetting> createState() => _EzIconSizeSettingState();
}

class _EzIconSizeSettingState extends State<EzIconSizeSetting> {
  double iconSize = EzConfig.iconSize;

  @override
  Widget build(BuildContext context) => EzCol(children: <Widget>[
        Tooltip(
          message: EzConfig.l10n.gCenterReset,
          child: GestureDetector(
            onLongPress: () async {
              if (EzConfig.updateBoth || EzConfig.isDark) {
                await EzConfig.remove(darkIconSizeKey);
              }
              if (EzConfig.updateBoth || !EzConfig.isDark) {
                await EzConfig.remove(lightIconSizeKey);
              }

              setState(() => iconSize = defaultIconSize);

              if (widget.fullCheck && context.mounted) {
                EzConfig.pingRebuild(iconSize != EzConfig.iconSize ||
                    ezTextRebuildCheck(context));
              } else {
                EzConfig.pingRebuild(iconSize != EzConfig.iconSize);
              }
            },
            child: EzText(
              EzConfig.l10n.tsIconSize,
              style: EzConfig.styles.bodyLarge,
            ),
          ),
        ),
        EzTextBackground(
          EzRow(
            reverseHands: false,
            children: <Widget>[
              // Minus
              (iconSize > minIconSize)
                  ? EzIconButton(
                      onPressed: () async {
                        iconSize -= iconDelta;
                        if (EzConfig.updateBoth || EzConfig.isDark) {
                          await EzConfig.setDouble(darkIconSizeKey, iconSize);
                        }
                        if (EzConfig.updateBoth || !EzConfig.isDark) {
                          await EzConfig.setDouble(lightIconSizeKey, iconSize);
                        }

                        setState(() {});

                        if (widget.fullCheck && context.mounted) {
                          EzConfig.pingRebuild(iconSize != EzConfig.iconSize ||
                              ezTextRebuildCheck(context));
                        } else {
                          EzConfig.pingRebuild(iconSize != EzConfig.iconSize);
                        }
                      },
                      tooltip:
                          '${EzConfig.l10n.gDecrease} ${EzConfig.l10n.tsIconSize.toLowerCase()}',
                      icon: const Icon(Icons.remove),
                      iconSize: iconSize,
                    )
                  : EzIconButton(
                      enabled: false,
                      tooltip: EzConfig.l10n.gMinimum,
                      icon: Icon(
                        Icons.remove,
                        color: EzConfig.colors.outline,
                      ),
                      iconSize: iconSize,
                    ),
              EzConfig.rowMargin,

              // Preview
              GestureDetector(
                onLongPress: () async {
                  if (EzConfig.updateBoth || EzConfig.isDark) {
                    await EzConfig.remove(darkIconSizeKey);
                  }
                  if (EzConfig.updateBoth || !EzConfig.isDark) {
                    await EzConfig.remove(lightIconSizeKey);
                  }

                  setState(() => iconSize = defaultIconSize);

                  if (widget.fullCheck && context.mounted) {
                    EzConfig.pingRebuild(iconSize != EzConfig.iconSize ||
                        ezTextRebuildCheck(context));
                  } else {
                    EzConfig.pingRebuild(iconSize != EzConfig.iconSize);
                  }
                },
                child: Icon(
                  Icons.sync_alt,
                  size: iconSize,
                  color: EzConfig.colors.onSurface,
                ),
              ),
              EzConfig.rowMargin,

              // Plus
              (iconSize < maxIconSize)
                  ? EzIconButton(
                      onPressed: () async {
                        iconSize += iconDelta;
                        if (EzConfig.updateBoth || EzConfig.isDark) {
                          await EzConfig.setDouble(darkIconSizeKey, iconSize);
                        }
                        if (EzConfig.updateBoth || !EzConfig.isDark) {
                          await EzConfig.setDouble(lightIconSizeKey, iconSize);
                        }

                        setState(() {});

                        if (widget.fullCheck && context.mounted) {
                          EzConfig.pingRebuild(iconSize != EzConfig.iconSize ||
                              ezTextRebuildCheck(context));
                        } else {
                          EzConfig.pingRebuild(iconSize != EzConfig.iconSize);
                        }
                      },
                      tooltip:
                          '${EzConfig.l10n.gIncrease} ${EzConfig.l10n.tsIconSize.toLowerCase()}',
                      icon: const Icon(Icons.add),
                      iconSize: iconSize,
                    )
                  : EzIconButton(
                      enabled: false,
                      tooltip: EzConfig.l10n.gMaximum,
                      icon: Icon(
                        Icons.add,
                        color: EzConfig.colors.outline,
                      ),
                      iconSize: iconSize,
                    ),
            ],
          ),
          useSurface: true,
          buttonShape: true,
          padding: EdgeInsets.zero,
        ),
      ]);
}
