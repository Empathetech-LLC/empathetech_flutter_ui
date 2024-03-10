/* empathetech_flutter_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

/// EFUI makes building user accessible and customizable apps Ez. So everyone can enjoy your great idea!
library empathetech_flutter_ui;

// Classes //

// Core
export 'src/classes/config.dart';

// Helpers
export 'src/classes/helpers/row.dart';
export 'src/classes/helpers/screen.dart';
export 'src/classes/helpers/scroll_view.dart';
export 'src/classes/helpers/spacer.dart';
export 'src/classes/helpers/warning.dart';

// Platform availability
export 'src/classes/platform_availability/alert_dialog.dart';
export 'src/classes/platform_availability/app_provider.dart';
export 'src/classes/platform_availability/back_action.dart';

// Responsive design
export 'src/classes/responsive_design/row_col.dart';
export 'src/classes/responsive_design/swap_scaffold.dart';
export 'src/classes/responsive_design/transitions.dart';

// Screen reader support
export 'src/classes/screen_reader_support/image.dart';
export 'src/classes/screen_reader_support/inline_link.dart';
export 'src/classes/screen_reader_support/link_image.dart';
export 'src/classes/screen_reader_support/link.dart';
export 'src/classes/screen_reader_support/new_line.dart';
export 'src/classes/screen_reader_support/plain_text.dart';
export 'src/classes/screen_reader_support/rich_text.dart';

// User customization
export 'src/classes/user_customization/text_style/bold_setting.dart';
export 'src/classes/user_customization/text_style/double_setting.dart';
export 'src/classes/user_customization/text_style/font_family_setting.dart';
export 'src/classes/user_customization/text_style/integer_setting.dart';
export 'src/classes/user_customization/text_style/italic_setting.dart';
export 'src/classes/user_customization/text_style/underline_setting.dart';

export 'src/classes/user_customization/color_setting.dart';
export 'src/classes/user_customization/dominant_hand_switch.dart';
export 'src/classes/user_customization/image_setting.dart';
export 'src/classes/user_customization/layout_setting.dart';
export 'src/classes/user_customization/locale_setting.dart';
export 'src/classes/user_customization/reset_button.dart';
export 'src/classes/user_customization/theme_mode_switch.dart';

// Constants //

export 'src/consts/config_keys.dart';
export 'src/consts/empathetech.dart';
export 'src/consts/google_fonts.dart';

// Functions //

export 'src/functions/aliases.dart';
export 'src/functions/colors.dart';
export 'src/functions/dialogs.dart';
export 'src/functions/images.dart';
export 'src/functions/navigators.dart';
export 'src/functions/text.dart';
export 'src/functions/theme_data.dart';

// l10n //

export 'src/l10n/efui_lang.dart';
