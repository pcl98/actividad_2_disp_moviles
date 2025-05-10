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

  String? _distritoSeleccionado;
  final List<String> _distritos = [
    'Centro',
    'Arganzuela',
    'Retiro',
    'Salamanca',
    'Chamartín',
    'Tetuán',
    'Chamberí',
    'FuencarralElPardo',
    'MoncloaAravaca',
    'Latina',
    'Carabanchel',
    'Usera',
    'PuenteDeVallecas',
    'Moratalaz',
    'CiudadLineal',
    'Hortaleza',
    'Villaverde',
    'VillaDeVallecas',
    'Vicálvaro',
    'SanBlasCanillejas',
    'Barajas',
  ];

  DateTime? _fechaSeleccionada;
  bool _esGratuito = false;

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    _localidadController.dispose();
    super.dispose();
  }

  /// Inserta espacios antes de mayúsculas para convertir los nombres de los distritos
  String _humanizar(String s) {
    return s
        .replaceAllMapped(RegExp(r'([A-Z])'), (m) => ' ${m.group(0)}')
        .trim();
  }

  Future _pickFecha() async {
    final ahora = DateTime.now();
    final fecha = await showDatePicker(
      context: context,
      initialDate: _fechaSeleccionada ?? ahora,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (fecha != null) {
      setState(() => _fechaSeleccionada = fecha);
    }
  }

  /*void _enviarFormulario() {
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
  }*/

  void _enviarFormulario() {
    if (_formKey.currentState!.validate()) {
      if (_fechaSeleccionada == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Selecciona una fecha')));
        return;
      }
      if (_distritoSeleccionado == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Selecciona un distrito')));
        return;
      }
      final nuevoEvento = Event(
        nombre: _nombreController.text,
        descripcion: _descripcionController.text,
        localidad: _localidadController.text,
        categoria: _categoriaSeleccionada!,
        distrito: _distritoSeleccionado!,
        fechaInicio: _fechaSeleccionada!,
        esGratuito: _esGratuito,
      );

      widget.onEventoCreado(nuevoEvento);
      Navigator.pop(context);
    }
  }

  /*@override
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

*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear evento')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Nombre
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del evento',
                ),
                validator:
                    (v) => (v == null || v.isEmpty) ? 'Ingresa nombre' : null,
              ),
              const SizedBox(height: 16),

              // Descripción
              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator:
                    (v) =>
                        (v == null || v.isEmpty) ? 'Ingresa descripción' : null,
              ),

              const SizedBox(height: 16),

              // Localidad
              TextFormField(
                controller: _localidadController,
                decoration: const InputDecoration(labelText: 'Localidad'),
                validator:
                    (v) =>
                        (v == null || v.isEmpty) ? 'Ingresa localidad' : null,
              ),

              const SizedBox(height: 16),

              // Categoría
              DropdownButtonFormField<String>(
                value: _categoriaSeleccionada,
                decoration: const InputDecoration(labelText: 'Categoría'),
                items:
                    _categorias.map((cat) {
                      return DropdownMenuItem(value: cat, child: Text(cat));
                    }).toList(),
                onChanged: (v) => setState(() => _categoriaSeleccionada = v),
                validator: (v) => v == null ? 'Selecciona categoría' : null,
              ),

              const SizedBox(height: 16),

              // Distrito
              DropdownButtonFormField<String>(
                value: _distritoSeleccionado,
                decoration: const InputDecoration(labelText: 'Distrito'),
                items:
                    _distritos.map((dist) {
                      return DropdownMenuItem(
                        value: dist,
                        child: Text(_humanizar(dist)),
                      );
                    }).toList(),
                onChanged: (v) => setState(() => _distritoSeleccionado = v),
                validator: (v) => v == null ? 'Selecciona distrito' : null,
              ),

              const SizedBox(height: 16),

              // Fecha de inicio
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Fecha de inicio',
                  suffixIcon: const Icon(Icons.calendar_today),
                ),
                controller: TextEditingController(
                  text:
                      _fechaSeleccionada == null
                          ? ''
                          : '${_fechaSeleccionada!.day}/${_fechaSeleccionada!.month}/${_fechaSeleccionada!.year}',
                ),
                onTap: _pickFecha,
                validator:
                    (_) => _fechaSeleccionada == null ? 'Elige fecha' : null,
              ),

              const SizedBox(height: 16),

              // Switch gratuito
              SwitchListTile(
                title: const Text('Evento gratuito'),
                value: _esGratuito,
                onChanged: (v) => setState(() => _esGratuito = v),
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _enviarFormulario,
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
