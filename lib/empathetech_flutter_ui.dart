/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

/// EFUI makes building accessible and user customizable UIs EZ. So anyone can enjoy your great idea!
library empathetech_flutter_ui;

import 'dart:io';
import 'dart:ui';
import 'dart:developer';
import 'package:path/path.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Classes
part 'classes/Eb2Casa.dart';
part 'classes/EzApp.dart';
part 'classes/EzColors.dart';
part 'classes/EzColorSetting.dart';
part 'classes/EzConfig.dart';
part 'classes/EzDialog.dart';
part 'classes/EzDominantHandSwitch.dart';
part 'classes/EzFontSetting.dart';
part 'classes/EzImage.dart';
part 'classes/EzImageSetting.dart';
part 'classes/EzLink.dart';
part 'classes/EzNotifications.dart';
part 'classes/EzRow.dart';
part 'classes/EzRowCol.dart';
part 'classes/EzScreen.dart';
part 'classes/EzScrollView.dart';
part 'classes/EzSelectableText.dart';
part 'classes/EzSliderSetting.dart';
part 'classes/EzSpacer.dart';
part 'classes/EzStoredImage.dart';
part 'classes/EzTextStyle.dart';
part 'classes/EzTextTheme.dart';
part 'classes/EzThemeModeSwitch.dart';
part 'classes/EzTransitions.dart';
part 'classes/EzVideoPlayer.dart';
part 'classes/EzWarning.dart';
part 'classes/EzWebLink.dart';
part 'classes/EzYesNo.dart';

// Functions
part 'functions/dialogs.dart';
part 'functions/ezThemeData.dart';
part 'functions/helpers.dart';
part 'functions/navigators.dart';
part 'functions/storage.dart';
part 'functions/textStyles.dart';

// Constants
part 'consts/colors.dart';
part 'consts/credits.dart';
part 'consts/googleFonts.dart';
part 'consts/sharedPreferences.dart';
