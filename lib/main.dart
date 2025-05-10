import 'package:flutter/material.dart';
import 'screens/event_list_screen.dart'; // Asegúrate de que la ruta sea correcta

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home:
          const EventListScreen(), // Cambia esta línea si deseas que se muestre EventListScreen al iniciar
    );
  }
}
