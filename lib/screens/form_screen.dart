import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();

  String nombre = '';
  String categoria = 'Concierto';
  DateTime? fecha;

  List<String> categorias = ['Concierto', 'Teatro', 'Deporte'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Evento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Campo Nombre
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nombre del evento'),
                onChanged: (value) {
                  setState(() {
                    nombre = value;
                  });
                },
              ),

              const SizedBox(height: 16),

              // Dropdown Categoría
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Categoría'),
                value: categoria,
                items: categorias
                    .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    categoria = value!;
                  });
                },
              ),

              const SizedBox(height: 16),

              // Botón para elegir fecha
              ElevatedButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (picked != null) {
                    setState(() {
                      fecha = picked;
                    });
                  }
                },
                child: Text(fecha == null
                    ? 'Seleccionar fecha'
                    : 'Fecha: ${fecha!.day}/${fecha!.month}/${fecha!.year}'),
              ),

              const SizedBox(height: 24),

              // Botón Guardar
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Aquí más adelante crearemos el evento
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Evento guardado')),
                    );
                  }
                },
                child: const Text('Guardar Evento'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
