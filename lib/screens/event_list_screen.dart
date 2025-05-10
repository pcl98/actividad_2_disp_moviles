import 'package:flutter/material.dart';
import 'package:actividad_2_disp_moviles/services/event_service.dart'; // Make sure the import is correct
import 'package:actividad_2_disp_moviles/models/event.dart';
import 'package:actividad_2_disp_moviles/screens/form_screen.dart'; // Make sure the import is correct

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
    _events = EventService().fetchEvents(); // Fetching the events
  }

  // Método para agregar un nuevo evento al principio de la lista
  void _agregarEvento(Event evento) {
    setState(() {
      _events = _events.then((value) {
        final nuevaLista = List<Event>.from(value); // Copiar la lista existente
        nuevaLista.insert(0, evento); // Insertar el nuevo evento al principio
        return nuevaLista; // Retornar la nueva lista con el evento al principio
      });
    });
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
          // Navigate to the FormScreen to create a new event
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormScreen(onEventoCreado: _agregarEvento),
            ),
          );
        },
        child: const Icon(Icons.add),
        tooltip: 'Añadir evento',
      ),
    );
  }
}
