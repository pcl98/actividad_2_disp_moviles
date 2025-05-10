class Event {
  final String nombre;
  final String descripcion;
  final String localidad;

  Event({
    required this.nombre,
    required this.descripcion,
    required this.localidad,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      nombre: json['title'] ?? 'Sin título',
      descripcion: json['description'] ?? 'Sin descripción',
      localidad: json['address']?['area']?['@id'] ?? ' ',
    );
  }
}
