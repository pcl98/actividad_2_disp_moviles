class Event {
  final String nombre;
  final String descripcion;
  final String localidad;
  final bool esGratuito;
  final DateTime fechaInicio;
  final String categoria;
  final String distrito;

  Event({
    required this.nombre,
    required this.descripcion,
    required this.localidad,
    required this.esGratuito,
    required this.fechaInicio,
    required this.categoria,
    required this.distrito,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      nombre: json['title'] ?? 'Sin título',
      descripcion: json['description'] ?? 'Sin descripción',
      localidad: json['event-location'] ?? 'Desconocido',
      esGratuito: json['free'] == 1,
      fechaInicio: DateTime.tryParse(json['dtstart'] ?? '') ?? DateTime.now(),
      categoria: _extraerUltimoSegmento(json['@type']) ?? 'Sin categoría',
      distrito:
          _extraerUltimoSegmento(json['address']?['district']?['@id']) ??
          'Desconocido',
    );
  }

  static String? _extraerUltimoSegmento(String? uri) {
    if (uri == null || uri.isEmpty) return null;
    return uri.split('/').last;
  }
}
