/* empathetech_flutter_ui
 * Copyright (c) 2023 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

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

part 'src/colors.dart';
part 'src/credits.dart';
part 'src/dialogs.dart';
part 'src/Eb2Casa.dart';
part 'src/EzApp.dart';
part 'src/EzColors.dart';
part 'src/EzColorSetting.dart';
part 'src/EzConfig.dart';
part 'src/EzDialog.dart';
part 'src/EzDominantHandSwitch.dart';
part 'src/EzFontSetting.dart';
part 'src/EzImage.dart';
part 'src/EzImageSetting.dart';
part 'src/EzLink.dart';
part 'src/EzNotifications.dart';
part 'src/EzRow.dart';
part 'src/EzRowCol.dart';
part 'src/EzScreen.dart';
part 'src/EzScrollView.dart';
part 'src/EzSelectableText.dart';
part 'src/EzSliderSetting.dart';
part 'src/EzSpacer.dart';
part 'src/EzStoredImage.dart';
part 'src/EzTextStyle.dart';
part 'src/EzTextTheme.dart';
part 'src/ezThemeData.dart';
part 'src/EzThemeModeSwitch.dart';
part 'src/EzTransitions.dart';
part 'src/EzVideoPlayer.dart';
part 'src/EzWarning.dart';
part 'src/EzWebLink.dart';
part 'src/EzYesNo.dart';
part 'src/googleFonts.dart';
part 'src/helpers.dart';
part 'src/navigators.dart';
part 'src/sharedPreferences.dart';
part 'src/storage.dart';
part 'src/textStyles.dart';
