/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class EzIconSizeSetting extends StatefulWidget {
  /// [EzConfig.redrawUI]/[EzConfig.rebuildUI] passthrough
  final bool updateBoth;

  /// Set to false when using this outside of [EzTextSettings]
  final bool fullCheck;

  const EzIconSizeSetting({
    super.key,
    required this.updateBoth,
    this.fullCheck = true,
  });

  @override
  State<EzIconSizeSetting> createState() => _EzIconSizeSettingState();
}

class _EzIconSizeSettingState extends State<EzIconSizeSetting> {
  double iconSize = EzConfig.iconSize;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Tooltip(
            message: EzConfig.l10n.gCenterReset,
            child: GestureDetector(
              onLongPress: () async {
                if (widget.updateBoth || EzConfig.isDark) {
                  await EzConfig.remove(darkIconSizeKey);
                }
                if (widget.updateBoth || !EzConfig.isDark) {
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
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Minus
                (iconSize > minIconSize)
                    ? EzIconButton(
                        onPressed: () async {
                          iconSize -= iconDelta;
                          if (widget.updateBoth || EzConfig.isDark) {
                            await EzConfig.setDouble(darkIconSizeKey, iconSize);
                          }
                          if (widget.updateBoth || !EzConfig.isDark) {
                            await EzConfig.setDouble(
                                lightIconSizeKey, iconSize);
                          }
                          setState(() {});
                          EzConfig.pingRebuild(
                              widget.fullCheck && context.mounted
                                  ? ezTextRebuildCheck(context)
                                  : iconSize != EzConfig.iconSize);
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
                EzMargin(vertical: false),

                // Preview
                GestureDetector(
                  onLongPress: () async {
                    if (widget.updateBoth || EzConfig.isDark) {
                      await EzConfig.remove(darkIconSizeKey);
                    }
                    if (widget.updateBoth || !EzConfig.isDark) {
                      await EzConfig.remove(lightIconSizeKey);
                    }
                    setState(() => iconSize = defaultIconSize);
                    EzConfig.pingRebuild(widget.fullCheck && context.mounted
                        ? ezTextRebuildCheck(context)
                        : iconSize != EzConfig.iconSize);
                  },
                  child: Icon(
                    Icons.sync_alt,
                    size: iconSize,
                    color: EzConfig.colors.onSurface,
                  ),
                ),
                EzMargin(vertical: false),

                // Plus
                (iconSize < maxIconSize)
                    ? EzIconButton(
                        onPressed: () async {
                          iconSize += iconDelta;
                          if (widget.updateBoth || EzConfig.isDark) {
                            await EzConfig.setDouble(darkIconSizeKey, iconSize);
                          }
                          if (widget.updateBoth || !EzConfig.isDark) {
                            await EzConfig.setDouble(
                                lightIconSizeKey, iconSize);
                          }
                          setState(() {});
                          EzConfig.pingRebuild(
                              widget.fullCheck && context.mounted
                                  ? ezTextRebuildCheck(context)
                                  : iconSize != EzConfig.iconSize);
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
            borderRadius: ezPillEdge,
          ),
        ],
      );
}
