import 'package:flutter/material.dart';
import 'package:actividad_2_disp_moviles/models/event.dart';
import 'package:actividad_2_disp_moviles/screens/result_screen.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _localidadController = TextEditingController();
  String? _categoriaSeleccionada; // Para el DropdownButton

  // Opciones para el DropdownButton (categorías de eventos, por ejemplo)
  final List<String> _categorias = ['Cultural', 'Deporte', 'Educación'];

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    _localidadController.dispose();
    super.dispose();
  }

  void _enviarFormulario() {
    if (_formKey.currentState!.validate()) {
      final nombre = _nombreController.text;
      final descripcion = _descripcionController.text;
      final localidad = _localidadController.text;

      final nuevoEvento = Event(
        nombre: nombre,
        descripcion: descripcion,
        localidad: localidad,
      );

      // Navegar a la pantalla de Resultados y pasar el evento creado
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) =>
                  ResultScreen(evento: nuevoEvento), // Pasamos el evento
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear evento')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre del evento'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre del evento';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descripcionController,
                decoration: InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una descripción';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _localidadController,
                decoration: InputDecoration(labelText: 'Localidad'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la localidad';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _categoriaSeleccionada,
                decoration: InputDecoration(labelText: 'Categoría del evento'),
                items:
                    _categorias.map((categoria) {
                      return DropdownMenuItem(
                        value: categoria,
                        child: Text(categoria),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    _categoriaSeleccionada = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Por favor seleccione una categoría';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _enviarFormulario,
                child: Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
