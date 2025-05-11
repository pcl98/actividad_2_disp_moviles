import 'package:flutter/material.dart';
import 'package:actividad_2_disp_moviles/models/event.dart';
import 'package:actividad_2_disp_moviles/services/event_service.dart';
import 'package:actividad_2_disp_moviles/services/preferences_service.dart';
import 'package:actividad_2_disp_moviles/screens/form_screen.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  State createState() => _EventListScreenState();
}

class _EventListScreenState extends State {
  final EventService _eventService = EventService();

  late Future<List> _futureEvents;
  bool _soloGratuitos = false;
  Set _prefDistritos = {};

  @override
  void initState() {
    super.initState();
    _futureEvents = _loadPrefsAndEvents();
  }

  Future<List> _loadPrefsAndEvents() async {
    final prefs = await PreferencesService.loadPreferences();
    _soloGratuitos = prefs['soloGratuitos'] as bool;
    _prefDistritos = (prefs['distritos'] as List).toSet();
    return _eventService.fetchEvents();
  }

  // Filtra la lista según filtros de distrito y gratuitos/pago
  List _filtrar(List events) {
    return events.where((e) {
      final matchDist =
          _prefDistritos.isEmpty || _prefDistritos.contains(e.distrito);
      final matchFree = !_soloGratuitos || e.esGratuito;
      return matchDist && matchFree;
    }).toList();
  }

  String _formatCategoria(String text) {
    final parts = _splitCamelCase(text);
    return parts.join('-');
  }

  String _formatDistrito(String text) {
    final parts = _splitCamelCase(text);
    return parts.join(' ');
  }

  List _splitCamelCase(String text) {
    return text
        .replaceAllMapped(
          RegExp(r'([a-z])([A-Z])'),
          (m) => '${m.group(1)} ${m.group(2)}',
        )
        .split(' ');
  }

  void _agregarEvento(Event evento) {
    setState(() {
      _futureEvents = _futureEvents.then((lista) {
        final nuevaLista = List.from(lista);
        nuevaLista.insert(0, evento);
        return nuevaLista;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/preferencias').then((_) {
                setState(() {
                  // recarga solo preferencias
                  PreferencesService.loadPreferences().then((prefs) {
                    setState(() {
                      _soloGratuitos = prefs['soloGratuitos'] as bool;
                      _prefDistritos = (prefs['distritos'] as List).toSet();
                    });
                  });
                });
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List>(
        future: _futureEvents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final allEvents = snapshot.data ?? [];
          final events = _filtrar(allEvents);
          if (events.isEmpty) {
            return const Center(child: Text('No hay eventos disponibles.'));
          }
          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: const Icon(Icons.event, size: 40),
                  title: Text(
                    event.nombre,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${_formatCategoria(event.categoria)} • ${_formatDistrito(event.distrito)}\n'
                    '${event.fechaInicio.day}/${event.fechaInicio.month}/${event.fechaInicio.year}\n'
                    '${event.esGratuito ? 'Gratuito' : 'De pago'}',
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FormScreen(onEventoCreado: _agregarEvento),
            ),
          );
        },
        child: const Icon(Icons.add),
        tooltip: 'Añadir evento',
      ),
    );
  }
}
