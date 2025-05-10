import 'package:flutter/material.dart';
import 'package:actividad_2_disp_moviles/services/event_service.dart'; // Asegúrate de que la ruta es correcta
import 'package:actividad_2_disp_moviles/models/event.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  late Future<List<Event>> _events;

  @override
  void initState() {
    super.initState();
    // Llama al servicio para obtener los eventos
    _events = EventService().fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Eventos')),
      body: FutureBuilder<List<Event>>(
        future: _events,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay eventos disponibles.'));
          } else {
            final events = snapshot.data!;

            return ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return ListTile(
                  title: Text(event.nombre),
                  subtitle: Text('${event.descripcion} - ${event.localidad}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}
