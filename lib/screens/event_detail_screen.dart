import 'package:flutter/material.dart';
import 'package:actividad_2_disp_moviles/models/event.dart';

class EventDetailScreen extends StatelessWidget {
  final Event event;

  const EventDetailScreen({super.key, required this.event});

  // Formateo de camelCase para mejorar UX
  String _formatCamelCase(String text) {
    return text
        .replaceAllMapped(
          RegExp(r'([a-z])([A-Z])'),
          (m) => '${m.group(1)} ${m.group(2)}',
        )
        .trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(event.nombre)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.nombre,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text('Categoría: ${_formatCamelCase(event.categoria)}'),
            Text('Distrito: ${_formatCamelCase(event.distrito)}'),
            Text(
              'Fecha: ${event.fechaInicio.day}/${event.fechaInicio.month}/${event.fechaInicio.year}',
            ),
            Text('Precio: ${event.esGratuito ? 'Gratuito' : 'De pago'}'),
            const SizedBox(height: 12),
            const Text(
              'Descripción:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              event.descripcion.isNotEmpty == true
                  ? event.descripcion!
                  : 'Sin descripción',
            ), // Por si la descripción está vacía
          ],
        ),
      ),
    );
  }
}
