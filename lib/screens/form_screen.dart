import 'package:flutter/material.dart';
import 'package:actividad_2_disp_moviles/models/event.dart';

class FormScreen extends StatefulWidget {
  final Function(Event)
  onEventoCreado; // The callback that receives the new event

  const FormScreen({super.key, required this.onEventoCreado});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _localidadController = TextEditingController();
  String? _categoriaSeleccionada;

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

      // Call the callback to add the event to the list
      widget.onEventoCreado(nuevoEvento);

      // Go back to the previous screen
      Navigator.pop(context);
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
