import 'package:flutter/material.dart';
import 'screens/event_list_screen.dart';
import 'screens/preferences_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eventos Madrid',
      theme: ThemeData(primarySwatch: Colors.indigo),
      initialRoute: '/',
      routes: {
        '/':
            (context) =>
                const EventListScreen(), // Pantalla inicial con la lista de eventos
        '/preferencias':
            (context) =>
                const PreferencesScreen(), // Pantalla de selección de preferencias
      },
    );
  }
}
