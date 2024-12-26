/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

const String appNameKey = 'appName';
const String publisherNameKey = 'publisherName';
const String domainNameKey = 'domainName';
const String textSettingsKey = 'textSettings';
const String layoutSettingsKey = 'layoutSettings';
const String colorSettingsKey = 'colorSettings';
const String imageSettingsKey = 'imageSettings';
const String vsCodeConfigKey = 'vsCodeConfig';
const String appDefaultsKey = 'appDefaults';

class EAGConfig {
  final String appName;
  final String publisherName;
  final String domainName;

  final bool textSettings;
  final bool layoutSettings;
  final bool colorSettings;
  final bool imageSettings;

  final String? vsCodeConfig;

  final Map<String, dynamic> appDefaults;

  EAGConfig({
    required this.appName,
    required this.publisherName,
    required this.domainName,
    required this.textSettings,
    required this.layoutSettings,
    required this.colorSettings,
    required this.imageSettings,
    this.vsCodeConfig,
    required this.appDefaults,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      appNameKey: appName,
      publisherNameKey: publisherName,
      domainNameKey: domainName,
      textSettingsKey: textSettings,
      layoutSettingsKey: layoutSettings,
      colorSettingsKey: colorSettings,
      imageSettingsKey: imageSettings,
      vsCodeConfigKey: vsCodeConfig,
      appDefaultsKey: ,
    };
  }

  factory EAGConfig.fromJson(dynamic json) {
    return EAGConfig(
      appName: json[appNameKey] as String,
      publisherName: json[publisherNameKey] as String,
      domainName: json[domainNameKey] as String,
      textSettings: json[textSettingsKey] as bool,
      layoutSettings: json[layoutSettingsKey] as bool,
      colorSettings: json[colorSettingsKey] as bool,
      imageSettings: json[imageSettingsKey] as bool,
      vsCodeConfig: json[vsCodeConfigKey] as String,
      appDefaults: ,
    );
  }

  @override
  String toString() {
    return '''{
  $appNameKey: $appName,
  $publisherNameKey: $publisherName,
  $domainNameKey: $domainName,
  $textSettingsKey: $textSettings,
  $layoutSettingsKey: $layoutSettings,
  $colorSettingsKey: $colorSettings,
  $imageSettingsKey: $imageSettings,
  $vsCodeConfigKey: $vsCodeConfig,
  $appDefaultsKey: BLARG,
}''';
  }
}
