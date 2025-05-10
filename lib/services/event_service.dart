import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:actividad_2_disp_moviles/models/event.dart';

class EventService {
  static const String apiUrl =
      'https://datos.madrid.es/egob/catalogo/300107-0-agenda-actividades-eventos.json';

  Future<List<Event>> fetchEvents() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      try {
        final decodedBody = utf8.decode(response.bodyBytes);
        final cleanedBody = _cleanJson(decodedBody); // Limpiar el JSON

        final jsonData = json.decode(cleanedBody);
        final List<dynamic> eventosJson = jsonData['@graph'];

        return eventosJson
            .map((eventJson) => Event.fromJson(eventJson))
            .toList();
      } catch (e) {
        print('Error al parsear JSON: $e');
        throw Exception('Error de formato al procesar los eventos');
      }
    } else {
      throw Exception('Failed to load events');
    }
  }

  // Limpiar el JSON eliminando secuencias de escape mal formateadas
  String _cleanJson(String json) {
    // Reemplazar cualquier coma antes de un cierre de llave o corchete
    json = json.replaceAll(
      RegExp(r',\s*[\}\]]'),
      '',
    ); // Eliminar comas innecesarias

    // Asegurarse de que 'free' tenga un valor correcto (booleano, null, o número)
    json = json.replaceAll(RegExp(r'"free":\s*,\s*'), '"free": null,');

    // Limpiar secuencias de escape mal formateadas, como \n, \t, \, etc.
    json = json.replaceAll(
      RegExp(r'\\(?![trn"\\/bfu])'),
      '\\\\',
    ); // Escapar solo los caracteres permitidos

    return json;
  }
}
