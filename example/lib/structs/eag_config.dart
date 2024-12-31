/* open_ui
 * Copyright (c) 2022-2024 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

const String appNameKey = 'appName';
const String publisherNameKey = 'publisherName';
const String domainNameKey = 'domainName';
const String descriptionKey = 'appDescription';

const String textSettingsKey = 'textSettings';
const String layoutSettingsKey = 'layoutSettings';
const String colorSettingsKey = 'colorSettings';
const String imageSettingsKey = 'imageSettings';

const String appDefaultsKey = 'appDefaults';

const String copyrightKey = 'copyrightNotice';
const String licenseKey = 'chosenLicense';
const String l10nConfigKey = 'l10nConfig';
const String analysisOptionsKey = 'analysisOptions';
const String vsCodeConfigKey = 'vsCodeConfig';

const String autoEmulateKey = 'autoEmulate';

/// JSON-serializable configuration for an Empathetech app
class EAGConfig {
  final String appName;
  final String publisherName;
  final String domainName;
  final String description;

  final bool textSettings;
  final bool layoutSettings;
  final bool colorSettings;
  final bool imageSettings;

  final Map<String, dynamic> appDefaults;

  final String? copyright;
  final String license;
  final String? l10nConfig;
  final String? analysisOptions;
  final String? vsCodeConfig;

  final bool? autoEmulate;

  EAGConfig({
    required this.appName,
    required this.publisherName,
    required this.domainName,
    required this.description,
    required this.textSettings,
    required this.layoutSettings,
    required this.colorSettings,
    required this.imageSettings,
    required this.appDefaults,
    this.copyright,
    required this.license,
    this.l10nConfig,
    this.analysisOptions,
    this.vsCodeConfig,
    this.autoEmulate,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      appNameKey: appName,
      publisherNameKey: publisherName,
      domainNameKey: domainName,
      descriptionKey: description,
      textSettingsKey: textSettings,
      layoutSettingsKey: layoutSettings,
      colorSettingsKey: colorSettings,
      imageSettingsKey: imageSettings,
      appDefaultsKey: appDefaults,
      copyrightKey: copyright,
      licenseKey: license,
      l10nConfigKey: l10nConfig,
      analysisOptionsKey: analysisOptions,
      vsCodeConfigKey: vsCodeConfig,
      autoEmulateKey: autoEmulate,
    };
  }

  factory EAGConfig.fromJson(dynamic json) {
    return EAGConfig(
      appName: json[appNameKey] as String,
      publisherName: json[publisherNameKey] as String,
      domainName: json[domainNameKey] as String,
      description: json[descriptionKey] as String,
      textSettings: json[textSettingsKey] as bool,
      layoutSettings: json[layoutSettingsKey] as bool,
      colorSettings: json[colorSettingsKey] as bool,
      imageSettings: json[imageSettingsKey] as bool,
      appDefaults: json[appDefaultsKey] as Map<String, dynamic>,
      copyright: json[copyrightKey] as String?,
      license: json[licenseKey] as String,
      l10nConfig: json[l10nConfigKey] as String?,
      analysisOptions: json[analysisOptionsKey] as String?,
      vsCodeConfig: json[vsCodeConfigKey] as String?,
      autoEmulate: json[autoEmulateKey] as bool?,
    );
  }

  @override
  String toString() {
    return '''{
  $appNameKey: $appName,
  $publisherNameKey: $publisherName,
  $domainNameKey: $domainName,
  $descriptionKey: $description,
  $textSettingsKey: $textSettings,
  $layoutSettingsKey: $layoutSettings,
  $colorSettingsKey: $colorSettings,
  $imageSettingsKey: $imageSettings,
  $appDefaultsKey: ${appDefaults.toString()}
  $copyrightKey: $copyright,
  $licenseKey: $license,
  $l10nConfigKey: $l10nConfig,
  $analysisOptionsKey: $analysisOptions,
  $vsCodeConfigKey: $vsCodeConfig,
  $autoEmulateKey: $autoEmulate,
}''';
  }
}
