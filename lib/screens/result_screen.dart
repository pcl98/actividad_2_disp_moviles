import 'package:flutter/material.dart';
import 'package:actividad_2_disp_moviles/models/event.dart';

class ResultScreen extends StatelessWidget {
  final Event evento;

  const ResultScreen({super.key, required this.evento});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Evento creado')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Nombre: ${evento.nombre}'),
            Text('Descripción: ${evento.descripcion}'),
            Text('Localidad: ${evento.localidad}'),
          ],
        ),
      ),
    );
  }
}
