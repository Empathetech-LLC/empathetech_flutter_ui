/* empathetech_flutter_ui
 * Copyright (c) 2026 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';

class EzIconSizeSetting extends StatefulWidget {
  final void Function() redraw;

  const EzIconSizeSetting({super.key, required this.redraw});

  @override
  State<EzIconSizeSetting> createState() => _EzIconSizeSettingState();
}

class _EzIconSizeSettingState extends State<EzIconSizeSetting> {
  double iconSize = EzConfig.iconSize;

  @override
  Widget build(BuildContext context) {
    final String iconSizeKey =
        EzConfig.isDark ? darkIconSizeKey : lightIconSizeKey;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Tooltip(
          message: EzConfig.l10n.gCenterReset,
          child: GestureDetector(
            onLongPress: () async {
              iconSize = defaultIconSize;
              await EzConfig.setDouble(iconSizeKey, defaultIconSize);
              widget.redraw();
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
                        await EzConfig.setDouble(iconSizeKey, iconSize);
                        widget.redraw();
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
                  iconSize = defaultIconSize;
                  await EzConfig.setDouble(iconSizeKey, defaultIconSize);
                  widget.redraw();
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
                        await EzConfig.setDouble(iconSizeKey, iconSize);
                        widget.redraw();
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
          borderRadius: ezPillShape,
        ),
      ],
    );
  }
}
