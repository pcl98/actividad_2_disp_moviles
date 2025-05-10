import 'package:flutter/material.dart';
import 'package:actividad_2_disp_moviles/services/event_service.dart'; // Asegúrate de que la ruta es correcta
import 'package:actividad_2_disp_moviles/models/event.dart';
import 'package:actividad_2_disp_moviles/screens/form_screen.dart'; // Asegúrate de que la ruta es correcta

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
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    leading: Icon(
                      Icons.event,
                      color: Theme.of(context).primaryColor,
                      size: 40.0,
                    ),
                    title: Text(
                      event.nombre,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    subtitle: Text(
                      '${event.descripcion}\n${event.localidad}',
                      style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar a la pantalla FormScreen para crear un nuevo evento
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormScreen()),
          );
        },
        child: const Icon(Icons.add),
        tooltip: 'Añadir evento',
      ),
    );
  }
}
