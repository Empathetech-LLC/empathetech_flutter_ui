# Empathetech Flutter UI <br><br> Crea apps para todos
[![en](https://img.shields.io/badge/lang-en-blue.svg)](https://github.com/Empathetech-LLC/empathetech_flutter_ui/blob/main/README.md)
[![es](https://img.shields.io/badge/lang-es-red.svg)](https://github.com/Empathetech-LLC/empathetech_flutter_ui/blob/main/README.es.md)
[![fr](https://img.shields.io/badge/lang-fr-white.svg)](https://github.com/Empathetech-LLC/empathetech_flutter_ui/blob/main/README.fr.md)

EFUI es un kit de inicio para la creación de aplicaciones de [Flutter](https://flutter.dev/) con una base sólida en todos los aspectos de la accesibilidad digital:

- **Disponibilidad de plataforma**
  - Gracias a Flutter, EFUI es totalmente multiplataforma. ¡Puedes utilizar EFUI para Android, iOS, Linux, MacOS, Windows y Web!
    - Gracias a la integración con los [Flutter Platform Widgets](https://pub.dev/packages/flutter_platform_widgets), las aplicaciones creadas con EFUI se adaptarán fácilmente al estilo Cupertino de Apple.
- **Diseño adaptable**
  - Aquí está la [definición](https://es.wikipedia.org/wiki/Dise%C3%B1o_web_adaptable)
  - Echa un vistazo a la [demo](#live) para verlo en acción
- **Compatible con lectores de pantalla**
  - Todos los widgets personalizados y la aplicación de ejemplo han sido verificados manualmente con [TalkBack](https://support.google.com/accessibility/android/answer/6006598?hl=en) y [VoiceOver](https://support.apple.com/guide/iphone/turn-on-and-practice-voiceover-iph3e2e415f/ios)
- **Personalización del usuario**
  - La única manera de ser realmente accesible para TODOS los clientes, es darles la libertad de elegir.
    - EFUI permite que todos los aspectos del tema de una aplicación sean controlados por el usuario.
- **Internacionalización**
  - Todo el [texto externo](./lib/src/l10n/) de EFUI está disponible en inglés, español y francés. Además, tiene la [infraestructura ](./l10n.yaml) para ilimitadas futuras traducciones.
    - Momento de lección moral: Recuerda que los LLM son una herramienta de aceleración. Pero para ganar una carrera, no basta con acelerar. Si sus traducciones son autogeneradas, dilo abiertamente. Las traducciones de EFUI empezaron siendo de inteligencia artificial y terminaron siendo de [inteligencia humana](#translations)

<br>Cuando construyes tus apps con EFUI, puedes llegar verdaderamente a cualquier audiencia. ¡Mejoremos internet juntos!

## Tabla de contenidos

* [Instalación](#installation)
* [Uso](#usage)
* [Demo](#demo)
* [Contribuyendo](#contributing)
* [Licencia](#license)
* [Créditos](#credits)

# Instalación

En el directorio base de tu aplicación, ejecuta

```bash
flutter pub add empathetech_flutter_ui
```

Y añade la siguiente importación a cualquier archivo que utilice la biblioteca de EFUI

```Dart
import 'package:empathetech_flutter_ui/empathetech_flutter_ui.dart';
```

## Tutoriales para principiantes

Si acabas de descubrir Flutter: ¡te damos la bienvenida! EFUI está lleno de comentarios para guiarte.

Aquí tienes algunos vídeos (no afiliados) que podrían resultarte útiles.

- [Tutorial para tu primera app](https://www.youtube.com/watch?v=xWV71C2kp38)
- [Laboratorio de código para tu primera app](https://www.youtube.com/watch?v=8sAyPDLorek)
- [Usando paquetes externos](https://www.youtube.com/watch?v=WdXcJdhWcEY)

# Uso

## TL;DR

--- Required ---
1. Initialize [EzConfig](./lib/src/classes/config.dart) in `void main()`
2. Use [EzAppProvider](./lib/src/classes/platform_availability/app_provider.dart) to build a [PlatformApp](https://pub.dev/documentation/flutter_platform_widgets/latest/flutter_platform_widgets/PlatformApp-class.html)<br>  - OR use [ezThemeData](./lib/src/functions/theme_data.dart) in any existing provider/app<br>  - OR use `EzConfig` to build a custom `ThemeData`

<br>--- Recommended ---
1. Copy the [settings sandbox](./example/lib/screens/) to your project
2. Enjoy

## Configuración

### Paso 1

#### Inicia [EzConfig](./lib/src/classes/config.dart) en `void main()`

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

#### Cómo funciona

`EzConfig` recopila y almacena los datos del tema de la aplicación, fusionando tus `customDefaults` con las [preferencias](https://pub.dev/packages/shared_preferences) guardadas por el usuario.

Una vez recopilados, `EzConfig` almacena los datos en una instancia de Singleton para lograr un acceso eficiente. `EzConfig` tiene una serie de métodos getter y setter para interacciones seguras con los datos del tema.

### Paso 2

#### Usa [EzAppProvider](./lib/src/classes/platform_availability/app_provider.dart) para crear una [PlatformApp](https://pub.dev/documentation/flutter_platform_widgets/latest/flutter_platform_widgets/PlatformApp-class.html)

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

#### Cómo funciona

`EzAppProvider` es un envoltorio para el [PlatformApp](https://pub.dev/documentation/flutter_platform_Widgets/latest/flutter_platform_Widgets/PlatformProvider-class.html) que usa [ezThemeData](./lib/src/functions/theme_data.dart) por defecto.

`ezThemeData` configura el esquema de color dinámico y el tema de texto, y actualiza algunos puntos táctiles para que tengan un mayor contraste por defecto.

Puedes utilizar tu propia aplicación/proveedor de apps con `ezThemeData` para conseguir el mismo efecto.

O incluso puedes crear tu propio tema base personalizado con los datos de `EzConfig`.

### Paso 3

#### Copia la [configuración sandbox](./example/lib/screens/) a tu proyecto

La app de ejemplo está diseñada para ser copiada y adaptada a las necesidades de tu propia app.

Copia/pega todos los [archivos de pantalla](./ejemplo/lib/screens/) y crea rutas a ellos en tu app.

Ejemplo de configuración de `GoRouter` ...
```Dart
///Enrutador basado en rutas para apps habilitadas para web
final GoRouter _yourAppRouter = GoRouter(
  initialLocation: homePath,
  routes: <RouteBase>[
    GoRoute(
      path: homePath,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: routes:<RouteBase>[
        /// ...todas tus rutas anteriores o futuras
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

¡Y listo!

**¡Es así de fácil!**

*NOTA:* El fragmento de código anterior asume que has renombrado el archivo (recién copiado) `Home.dart` y la clase `HomeScreen()` a `Settings.dart` y `SettingsScreen()`

#### Cómo funciona

¡Las pantallas de la app de ejemplo organizan todos los widgets que permitan la personalización del usuario de EFUI!

* [EzDominantHandSwitch](./lib/src/classes/user_customization/dominant_hand_switch.dart): Una opción para cambiar los puntos de contacto comunes para ayudar a los zurdos.
* [EzThemeModeSwitch](./lib/src/classes/user_customization/theme_mode_swtich.dart): Un menú para seleccionar el tema de la aplicación: claro, oscuro, sistema.
* [EzLocaleSetting](./lib/src/classes/user_customization/local_setting.dart): Un menú para actualizar el idioma de la app. EFUI actualmente está en inglés, español y francés.
* [TextSettings](./lib/src/classes/user_customization/text_style/): Una colección de widgets para controlar los estilos de texto de la app.
* [EzLayoutSetting](./lib/src/classes/user_customization/layout_setting.dart): Un widget deslizante dinámico con previsualizaciones en vivo, para actualizar el diseño de la app: margen, relleno y espaciado.
* [EzColorSetting](./lib/src/classes/user_customization/color_setting.dart): Un selector de color para actualizar cada entrada en el esquema de color de la app.
* [EzImageSetting](./lib/src/classes/user_customization/image_setting.dart): Un selector de imágenes para actualizar los recursos de la app.
* [EzResetButton](./lib/src/classes/user_customization/reset_button.dart): Un botón personalizable para restablecer grupos de preferencias.

Por defecto, todas las configuraciones del [ajustes del tema básico](./lib/src/consts/config_keys.dart) están disponibles. Podrás acceder a configuraciones adicionales en `customDefaults` ¡y las podrás modificar con esos widgets también!

En caso de que quieras mantener algunos valores del tema constantes, simplemente elimina el/los widget/s de configuración emparejado/s.

### Paso 4

#### ¡Disfruta!

Las bases de la **disponibilidad de la plataforma** y la **personalización del usuario** solo las tienes que configurar una vez y te puedes olvidar de ellas, a no ser que alguna librería externa rompa algo.

Pero a medida que tus apps crezcan, otras bases requerirán un desarrollo continuo.

¡Por suerte, EFUI te puede ayudar con eso también!
* [Diseño adaptable](./lib/src/classes/responsive_design/): Widgets que ayudan en la construcción de una UI/UX adaptable
* [Screen reader support](./lib/src/classes/screen_reader_support/): Widgets con semántica simplificada

<br>Sí, es mucha información de golpe, pero con esto ya debería bastar para que empieces. Una vez entiendas todo mejor, ¡hemos organizado el repositorio para ayudarte a explorar!

# Demo

### [Android](https://play.google.com/store/apps/details?id=net.empathetech.open_ui)
### [iOS](https://apps.apple.com/us/app/open-ui/id6499560244)
### [Desktop](https://github.com/Empathetech-LLC/empathetech_flutter_ui/releases)
### [Web](https://www.empathetech.net/#/settings)

# Contribuyendo

## ¡Buenas ondas!

Si construyes algo con EFUI, ¡infórmanos!

## Tiempo

Ponte en contacto con la [comunidad](mailto:community@empathetech.net?subject=Becoming%20a%20contributor) para colaborar. ¡Nunca faltan ideas, solo tiempo!

### Traducciones

Si hablas inglés y un idioma no disponible, ¡no dudes en ponerte en contacto con nosotros! Cuantos más seamos, mejor.

O bien: Si hablas inglés y un idioma soportado actualmente, y ves algo que está mal, ¡ponte en contacto con nosotros! Cooperando, ganamos todos.

## Dinero

¡Muchas gracias por las donaciones, grandes y pequeñas!

### Paypal

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/donate/?hosted_button_id=NGEL6AB5A6KNL)

### [Venmo](https://venmo.com/empathetech)

### [Cash App](https://cash.app/$empathetech)

### [Patreon](https://patreon.com/empathetech)

### [Buy Me a Coffee](https://www.buymeacoffee.com/empathetech)

### [Ko-fi](https://ko-fi.com/empathetech)

# Licencia

[GNU GPLv3](LICENSE)

# Créditos

## Traducciones

Español: [Sara Herrera](https://www.fiverr.com/saraqua)
