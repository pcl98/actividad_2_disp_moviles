import 'package:flutter/material.dart';

/// PANTALLA PRINCIPAL

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Eventos en Madrid')),
      body: Center(child: Text('¡Bienvenido a la app de eventos!')),
    );
  }
}
