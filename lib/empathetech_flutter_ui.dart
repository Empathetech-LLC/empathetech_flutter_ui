/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

/// EFUI makes building accessible and user customizable UIs EZ. So anyone can enjoy your great idea!
library empathetech_flutter_ui;

// Classes //

// Responsive design
export 'src/classes/responsive-design/EzRow.dart';
export 'src/classes/responsive-design/EzRowCol.dart';
export 'src/classes/responsive-design/EzScrollView.dart';
export 'src/classes/responsive-design/EzSpacer.dart';
export 'src/classes/responsive-design/EzSwapScaffold.dart';
export 'src/classes/responsive-design/EzTransitions.dart';

// Screen readers
export 'src/classes/screen-readers/EzImage.dart';

// Screen readers: text
export 'src/classes/screen-readers/text/EzLink.dart';
export 'src/classes/screen-readers/text/EzPlainText.dart';
export 'src/classes/screen-readers/text/EzText.dart';
export 'src/classes/screen-readers/text/EzTextBlock.dart';
export 'src/classes/screen-readers/text/EzTextStyle.dart';
export 'src/classes/screen-readers/text/EzWarning.dart';
export 'src/classes/screen-readers/text/EzWebLink.dart';

// User-customization
export 'src/classes/user-customization/EzAppProvider.dart';
export 'src/classes/user-customization/EzConfig.dart';

// User-customization: settings
export 'src/classes/user-customization/settings/EzColorSetting.dart';
export 'src/classes/user-customization/settings/EzDominantHandSwitch.dart';
export 'src/classes/user-customization/settings/EzFontSetting.dart';
export 'src/classes/user-customization/settings/EzImageSetting.dart';
export 'src/classes/user-customization/settings/EzResetButton.dart';
export 'src/classes/user-customization/settings/EzSliderSetting.dart';
export 'src/classes/user-customization/settings/EzThemeModeSwitch.dart';

// General
export 'src/classes/EzAlertDialog.dart';
export 'src/classes/EzBackAction.dart';
export 'src/classes/EzScreen.dart';
export 'src/classes/EzVideoPlayer.dart';

// Constants //

export 'src/consts/empathetechConfig.dart';
export 'src/consts/googleFonts.dart';
export 'src/consts/keys.dart';

// Enums //

export 'src/enums/ButtonVis.dart';
export 'src/enums/Hand.dart';
export 'src/enums/SliderSettingType.dart';

// Functions //

export 'src/functions/aliases.dart';
export 'src/functions/colors.dart';
export 'src/functions/customDialogs.dart';
export 'src/functions/ezThemeData.dart';
export 'src/functions/navigators.dart';
export 'src/functions/storage.dart';
export 'src/functions/text.dart';

// l10n //

export 'src/l10n/efui_phrases.dart';
