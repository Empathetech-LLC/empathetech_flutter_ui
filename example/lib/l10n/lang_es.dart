import 'lang.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class LangEs extends Lang {
  LangEs([String locale = 'es']) : super(locale);

  @override
  String get gSuccess => '¡Éxito!';

  @override
  String get gFailure => 'Fracaso';

  @override
  String get csLoad => 'Cargar configuración';

  @override
  String get csResetHint => 'Activa y confirma lo que se debe reiniciar.';

  @override
  String get csResetBuilder => 'Valores del constructor';

  @override
  String get csResetApp => 'Configuración de la aplicación';

  @override
  String get csResetBoth => 'Ambos';

  @override
  String get csResetNothing => 'Nada';

  @override
  String get rsWouldYou => 'Te gustaría...';

  @override
  String get rsInstall => 'Instalarlo';

  @override
  String get rsRun => 'Ejecutarlo';

  @override
  String get rsWipe => 'Borrarlo';

  @override
  String get rsNextTime => '¡Éxito, crucemos los dedos para la próxima!';

  @override
  String get rsAnotherOne =>
      'Otro fracaso; probablemente deberías tomar el control...';

  @override
  String get rsLeave => 'Dejarlo';
}
