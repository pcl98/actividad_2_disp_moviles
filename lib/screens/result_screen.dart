import 'package:flutter/material.dart';
import 'package:actividad_2_disp_moviles/models/event.dart'; // Asegúrate de tener el modelo de evento

class ResultScreen extends StatelessWidget {
  final List<Event> eventos;

  const ResultScreen({super.key, required this.eventos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Eventos creados')),
      body:
          eventos.isEmpty
              ? Center(child: Text('No hay eventos creados'))
              : ListView.builder(
                itemCount: eventos.length,
                itemBuilder: (context, index) {
                  final evento = eventos[index];
                  return ListTile(
                    title: Text(evento.nombre),
                    subtitle: Text(
                      'Descripción: ${evento.descripcion}\nLocalidad: ${evento.localidad}',
                    ),
                  );
                },
              ),
    );
  }
}
