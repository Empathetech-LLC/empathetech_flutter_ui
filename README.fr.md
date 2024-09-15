# Empathetech Flutter UI <br><br> Créer des applications pour tous
[![en](https://img.shields.io/badge/lang-en-blue.svg)](https://github.com/Empathetech-LLC/empathetech_flutter_ui/blob/main/README.md)
[![es](https://img.shields.io/badge/lang-es-red.svg)](https://github.com/Empathetech-LLC/empathetech_flutter_ui/blob/main/README.es.md)
[![fr](https://img.shields.io/badge/lang-fr-white.svg)](https://github.com/Empathetech-LLC/empathetech_flutter_ui/blob/main/README.fr.md)

EFUI est un kit de démarrage pour créer des applications [Flutter](https://flutter.dev/) avec une base solide dans tous les aspects de l’accessibilité numérique :

- **Multiplateforme**
  - Grâce à Flutter, EFUI est entièrement multiplateforme ! Vous pouvez utiliser EFUI pour créer sur Android, iOS, Linux, MacOS, Windows et Web !
    - Grâce à l'intégration avec les [Flutter Platform Widgets](https://pub.dev/packages/flutter_platform_widgets), les applications créées avec EFUI s'adapteront avec élégance au style de Cupertino (Apple)
- **Design réactif**
  - Voici la [définition](https://developer.mozilla.org/en-US/docs/Learn/CSS/CSS_layout/Responsive_Design)
  - Testez la [démo](#live) pour le voir en action
- **Prise en charge du lecteur d'écran**
  - Tous les widgets personnalisés et le modèle d'application ont été vérifiés manuellement avec [TalkBack](https://support.google.com/accessibility/android/answer/6006598?hl=en) et [VoiceOver](https://support.apple.com/guide/iphone/turn-on-and-practice-voiceover-iph3e2e415f/ios)
  - La seule façon d’être véritablement accessible à TOUS les clients est de leur donner la liberté de choix.
    - EFUI expose chaque aspect du thème d'une application pour qu'il soit contrôlé par l'utilisateur.
- **Internationalisation**
  - L'intégralité du [texte externe](./lib/src/l10n/) d'EFUI, tout comme l'[infrastructure](./l10n.yaml), ont été traduits en espagnol et en français pour des traductions ultérieures illimitées.
    - Moment de morale : Gardez à l'esprit que les LLM sont un outil d'accélération. Gagner une course ne se résume pas à l'accélération. Si vos traductions sont générées automatiquement, indiquez-le. Les traductions d'EFUI ont été traduites artificiellement, et se sont revérifiées par des [humains](#translations).

<br>Grâce à EFUI, vos applications peuvent réellement toucher tous les publics. Ensemble, faisons d'Internet un endroit meilleur !

## Sommaire

* [Installation](#installation)
* [Utilisation](#utilisation)
* [Démo](#démo)
* [Contributions](#contributions)
* [Licence](#licence)
* [Crédits](#crédits)

# Installation

Dans le répertoire de base de votre application, exécutez

```bash
flutter pub add empathetech_flutter_ui
```

Et ajoutez la ligne d'importation suivante à tous les fichiers qui utilisent la bibliothèque EFUI

```Dart
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
```

## Tutoriels de démarrage

Si vous débutez avec Flutter : Bienvenue ! EFUI regorge de commentaires pour vous aider sur votre chemin.

Voici quelques vidéos (non-affiliées) qui pourraient également vous être utiles.

- [Première application](https://www.youtube.com/watch?v=xWV71C2kp38)
- [Première application avec un codelab](https://www.youtube.com/watch?v=8sAyPDLorek)
- [Utiliser des paquets externes](https://www.youtube.com/watch?v=WdXcJdhWcEY)

# Utilisation

## TL;DR

--- Requis ---
1. Initialisez [EzConfig](./lib/src/classes/config.dart) dans `void main()`
2. Utilisez [EzAppProvider](./lib/src/classes/platform_availability/app_provider.dart) pour créer une [PlatformApp](https://pub.dev/documentation/flutter_platform_widgets/latest/flutter_platform_widgets/PlatformApp-class.html)<br>  - OU utilisez [ezThemeData](./lib/src/functions/theme_data.dart) dans n'importe quel fournisseur/application existant<br>  - OU utilisez `EzConfig` pour construire un `ThemeData` personnalisé

<br>--- Recommandé ---

- Copiez les [paramètres bac à sable](./example/lib/screens/) dans votre projet

## Setup

### Step 1

#### Initialisez [EzConfig](./lib/src/classes/config.dart) dans `void main()`

```Dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  EzConfig.init(
    // Paths to any locally stored images the app uses
    assetPaths: {},

    preferences: prefs,

    // Your brand colors, custom styling, etc
    defaults: empathetechConfig, // is an optional starter
  );
  
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const YourApp());
}
```

#### Fonctionnement

`EzConfig` collecte et stocke les données de thème de l'application, en fusionnant vos `customDefaults` avec les [préférences](https://pub.dev/packages/shared_preferences) enregistrées de l'utilisateur.

Une fois collectées, `EzConfig` stocke les données dans une instance Singleton pour un accès efficace. `EzConfig` dispose d'une série de méthodes getter et setter pour des interactions sécurisées avec les données du thème.

### Étape 2

#### Utilisez [EzAppProvider](./lib/src/classes/platform_availability/app_provider.dart) pour créer une [PlatformApp](https://pub.dev/documentation/flutter_platform_widgets/latest/flutter_platform_widgets/PlatformApp-class.html)

```Dart
class YourApp extends StatelessWidget {
  const YourApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EzAppProvider(
      app: PlatformApp.router(
        debugShowCheckedModeBanner: false,

        // Language handlers
        localizationsDelegates: {
          LocaleNamesLocalizationsDelegate(),
          ...EFUILang.localizationsDelegates,
          YourAppFeedbackLocalizationsDelegate,
        },

        // Supported languages
        supportedLocales: EFUILang.supportedLocales,ß

        // Current language
        locale: EzConfig.getLocale(),

        title: yourAppTitle,
        routerConfig: yourAppRouter,
      ),
    );
  }
}
```

#### Fonctionnement

`EzAppProvider` est un wrapper [PlatformProvider](https://pub.dev/documentation/flutter_platform_Widgets/latest/flutter_platform_Widgets/PlatformProvider-class.html) qui utilise [ezThemeData](./lib/src/functions/theme_data.dart) par défaut.

`ezThemeData` configure le jeu de couleurs dynamique et le thème de texte, et met à jour certains points de contact pour qu'ils aient un contraste plus élevé par défaut.

Vous êtes plus que bienvenu à utiliser votre propre application/fournisseur d'application avec `ezThemeData` pour le même effet.

Vous pouvez même créer votre propre thème de base entièrement personnalisé avec les données `EzConfig`.

### Étape 3

#### Copiez les [paramètres bac à sable](./example/lib/screens/) dans votre projet

Le modèle d'application est conçu pour être une solution intégrée pour les paramètres de vos applications.

Copiez/collez tous les [fichiers d'interfaces](./example/lib/screens/) et créez des chemins vers eux dans les routes de vos applications.

Exemple de configuration `GoRouter`...
```Dart
/// A path based router for web-enabled apps
final GoRouter _yourAppRouter = GoRouter(
  initialLocation: homePath,
  routes: <RouteBase>[
    GoRoute(
      path: homePath,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: routes:<RouteBase>[
        /// ...all of your pre/soon to be existing Routes
        GoRoute(
          path: settingsRoute,
          builder: (BuildContext context, GoRouterState state) {
            return const SettingsScreen();
          },
          routes:<RouteBase>[
            GoRoute(
              path: textSettingsPath,
              builder: (BuildContext context, GoRouterState state) {
                return const TextSettingsScreen();
              },
            ),
            GoRoute(
              path: layoutSettingsPath,
              builder: (BuildContext context, GoRouterState state) {
                return const LayoutSettingsScreen();
              },
            ),
            GoRoute(
              path: colorSettingsPath,
              builder: (BuildContext context, GoRouterState state) {
                return const ColorSettingsScreen();
              },
            ),
            GoRoute(
              path: imageSettingsPath,
              builder: (BuildContext context, GoRouterState state) {
                return const ImageSettingsScreen();
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
```

Et voilà !

**C'est aussi simple que ça !**

*REMARQUE :* L'extrait de code ci-dessus suppose que vous avez renommé le fichier `Home.dart` (qui vient d'être copié) ainsi que la classe `HomeScreen()` respectivement en `Settings.dart` et `SettingsScreen()`.

#### Fonctionnement

Les écrans du modèle d'application organisent soigneusement tous les widgets personnalisés qui permettent la personnalisation utilisateur d'EFUI !

* [EzDominantHandSwitch](./lib/src/classes/user_customization/dominant_hand_switch.dart) : Une bascule permettant de changer les points de contact courants pour bénéficier aux gauchers.
* [EzThemeModeSwitch](./lib/src/classes/user_customization/theme_mode_swtich.dart) : Un menu à bascule pour sélectionner le thème de l'application : clair, sombre, système.
* [EzLocaleSetting](./lib/src/classes/user_customization/local_setting.dart) : Un menu pour mettre à jour la langue de l'application. EFUI prend actuellement en charge l'anglais, l'espagnol et le français.
* [TextSettings](./lib/src/classes/user_customization/text_style/) : Une collection de widgets personnalisés pour contrôler les TextStyles de l'application.
* [EzLayoutSetting](./lib/src/classes/user_customization/layout_setting.dart) : Un widget de curseur dynamique, avec des aperçus en direct, pour mettre à jour la mise en page de l'application : marge extérieure, marge intérieure et espacement.
* [EzColorSetting](./lib/src/classes/user_customization/color_setting.dart) : Un sélecteur de couleurs pour mettre à jour chaque entrée dans le ColorScheme de l'application.
* [EzImageSetting](./lib/src/classes/user_customization/image_setting.dart) : Un sélecteur d'images pour mettre à jour les ressources de l'application.
* [EzResetButton](./lib/src/classes/user_customization/reset_button.dart) : Un bouton personnalisable pour réinitialiser des groupes de préférences.

Par défaut, chaque [paramètre de thème](./lib/src/consts/config_keys.dart) de base est exposé. Des clés supplémentaires fournies à `customDefaults` peuvent également être mises à jour avec ces widgets !

Si vous souhaitez conserver des valeurs de thème constantes, supprimez simplement le(s) widget(s) de paramètre associé(s).

### Étape 4

#### Profitez !

Les piliers de la **disponibilité multiplateforme** et de la **personnalisation utilisateur** sont "configurez et oubliez"; Excluez toutes les bibliothèques externes qui causent des problèmes.

Mais, à mesure que vos applications se développent, les autres piliers nécessitent un développement continu.

Heureusement, EFUI vous soutient pour ça aussi !
* [Design réactif](./lib/src/classes/responsive_design/) : Widgets qui aident à créer une interface utilisateur/expérience utilisateur réactive
* [Prise en charge du lecteur d'écran](./lib/src/classes/screen_reader_support/) : Widgets avec une sémantique simplifiée

<br>Au risque de vous surcharger en informations, cela devrait suffire à vous lancer. Une fois que vous vous sentirez à l'aise, le dépôt a été organisé pour faciliter l'exploration !

# Démo

### [Android](https://play.google.com/store/apps/details?id=net.empathetech.open_ui)
### [iOS](https://apps.apple.com/us/app/open-ui/id6499560244)
### [Desktop](https://github.com/Empathetech-LLC/empathetech_flutter_ui/releases)
### [Web](https://www.empathetech.net/#/settings)

# Contributions

## Projets

Si vous créez quelque chose avec EFUI, faites-le nous savoir !

## Temps

N'hésitez pas à contacter le contact [communauté](mailto:community@empathetech.net?subject=Becoming%20a%20contributor) pour devenir contributeur. Les idées ne manquent jamais, seulement le temps !

### Translations

Si vous parlez anglais ainsi qu'une langue actuellement non prise en charge, n'hésitez pas à nous contacter ! Plus on est de fous, plus on rit.

Si vous parlez anglais et une langue actuellement prise en charge, et que vous constatez une anomalie, n'hésitez pas à nous contacter !

## Financières

Merci beaucoup pour tous vos dons !

### [GoFundMe](https://gofund.me/c047d07e)

### [Patreon](https://patreon.com/empathetech)

### [Buy Me a Coffee](https://www.buymeacoffee.com/empathetech)

### [Ko-fi](https://ko-fi.com/empathetech)

### Paypal

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/donate/?hosted_button_id=NGEL6AB5A6KNL)

### [Venmo](https://venmo.com/empathetech)

### [Cash App](https://cash.app/$empathetech)

# Licence

[GNU GPLv3](LICENSE)

# Crédits

## Traductions

[Alexis Nguyen](https://www.fiverr.com/alexisnguyen2)