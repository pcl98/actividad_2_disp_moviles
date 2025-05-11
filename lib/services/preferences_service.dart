import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _keyDistritos = 'distritos';
  static const String _keySoloGratuitos = 'soloGratuitos';

  /// Guarda las listas de distritos y la opción de gratuitos
  static Future savePreferences({
    required List distritos,
    required bool soloGratuitos,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_keyDistritos, distritos.cast<String>());
    await prefs.setBool(_keySoloGratuitos, soloGratuitos);
  }

  /// Carga las preferencias guardadas
  static Future<Map<String, dynamic>> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final distritos = prefs.getStringList(_keyDistritos) ?? [];
    final soloGratuitos = prefs.getBool(_keySoloGratuitos) ?? false;
    return {'distritos': distritos, 'soloGratuitos': soloGratuitos};
  }
}
