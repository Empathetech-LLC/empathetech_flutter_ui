/* open_ui
 * Copyright (c) 2025 Empathetech LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

const String appNameKey = 'appName';
const String publisherNameKey = 'publisherName';
const String appDescriptionKey = 'appDescription';
const String domainNameKey = 'domainName';
const String supportEmailKey = 'supportEmail';

const String colorSettingsKey = 'colorSettings';
const String designSettingsKey = 'designSettings';
const String layoutSettingsKey = 'layoutSettings';
const String textSettingsKey = 'textSettings';

const String appDefaultsKey = 'appDefaults';

const String flutterPathKey = 'flutterPath';

const String workPathKey = 'workPath';
const String copyrightKey = 'copyright';
const String licenseKey = 'license';
const String l10nConfigKey = 'l10nConfig';
const String analysisOptionsKey = 'analysisOptions';
const String vsCodeConfigKey = 'vsCodeConfig';

/// JSON-serializable configuration for an Empathetech app
class EAGConfig {
  final String appName;
  final String publisherName;
  final String appDescription;
  final String domainName;
  final String? supportEmail;

  final bool colorSettings;
  final bool designSettings;
  final bool layoutSettings;
  final bool textSettings;

  final Map<String, dynamic> appDefaults;

  final String? flutterPath;

  final String? workPath;
  final String? copyright;
  final String license;
  final String? l10nConfig;
  final String? analysisOptions;
  final String? vsCodeConfig;

  EAGConfig({
    required this.appName,
    required this.publisherName,
    required this.appDescription,
    required this.domainName,
    this.supportEmail,
    required this.colorSettings,
    required this.designSettings,
    required this.layoutSettings,
    required this.textSettings,
    required this.appDefaults,
    this.flutterPath,
    this.workPath,
    this.copyright,
    required this.license,
    this.l10nConfig,
    this.analysisOptions,
    this.vsCodeConfig,
  });

  factory EAGConfig.fromJson(dynamic json) {
    return EAGConfig(
      appName: json[appNameKey] as String,
      publisherName: json[publisherNameKey] as String,
      appDescription: json[appDescriptionKey] as String,
      domainName: json[domainNameKey] as String,
      supportEmail: json[supportEmailKey] as String?,
      colorSettings: json[colorSettingsKey] as bool,
      designSettings: json[designSettingsKey] as bool,
      layoutSettings: json[layoutSettingsKey] as bool,
      textSettings: json[textSettingsKey] as bool,
      appDefaults: json[appDefaultsKey] as Map<String, dynamic>,
      flutterPath: json[flutterPathKey] as String?,
      workPath: json[workPathKey] as String?,
      copyright: json[copyrightKey] as String?,
      license: json[licenseKey] as String,
      l10nConfig: json[l10nConfigKey] as String?,
      analysisOptions: json[analysisOptionsKey] as String?,
      vsCodeConfig: json[vsCodeConfigKey] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      appNameKey: appName,
      publisherNameKey: publisherName,
      appDescriptionKey: appDescription,
      domainNameKey: domainName,
      supportEmailKey: supportEmail,
      colorSettingsKey: colorSettings,
      designSettingsKey: designSettings,
      layoutSettingsKey: layoutSettings,
      textSettingsKey: textSettings,
      appDefaultsKey: appDefaults,
      flutterPathKey: flutterPath,
      workPathKey: workPath,
      copyrightKey: copyright,
      licenseKey: license,
      l10nConfigKey: l10nConfig,
      analysisOptionsKey: analysisOptions,
      vsCodeConfigKey: vsCodeConfig,
    };
  }

  @override
  String toString() {
    return '''{
  $appNameKey: $appName,
  $publisherNameKey: $publisherName,
  $appDescriptionKey: $appDescription,
  $domainNameKey: $domainName,
  $supportEmailKey: $supportEmail,
  $colorSettingsKey: $colorSettings,
  $designSettingsKey: $designSettings,
  $layoutSettingsKey: $layoutSettings,
  $textSettingsKey: $textSettings,
  $appDefaultsKey: ${appDefaults.toString()}
  $flutterPathKey: $flutterPath,
  $workPathKey: $workPath,
  $copyrightKey: $copyright,
  $licenseKey: $license,
  $l10nConfigKey: $l10nConfig,
  $analysisOptionsKey: $analysisOptions,
  $vsCodeConfigKey: $vsCodeConfig,
}''';
  }
}
