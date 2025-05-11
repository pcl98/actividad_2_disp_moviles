import 'package:flutter/material.dart';
import 'package:actividad_2_disp_moviles/services/preferences_service.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State {
  // Opciones disponibles para distritos
  final List _distritos = [
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

  // Selecciones del usuario
  final Set _selectedDistritos = {};
  bool _soloGratuitos = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future _loadPrefs() async {
    final prefs = await PreferencesService.loadPreferences();
    setState(() {
      _selectedDistritos.addAll(prefs['distritos']!);
      _soloGratuitos = prefs['soloGratuitos'];
      _loading = false;
    });
  }

  Future _savePrefs() async {
    await PreferencesService.savePreferences(
      distritos: _selectedDistritos.toList(),
      soloGratuitos: _soloGratuitos,
    );
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Preferencias guardadas')));
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Preferencias')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Preferencias')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Distritos favoritos',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ..._distritos.map(
              (dist) => CheckboxListTile(
                title: Text(
                  dist
                      .replaceAllMapped(
                        RegExp(r'([A-Z])'),
                        (m) => ' ${m.group(0)}',
                      )
                      .trim(),
                ),
                value: _selectedDistritos.contains(dist),
                onChanged: (checked) {
                  setState(() {
                    if (checked == true)
                      _selectedDistritos.add(dist);
                    else
                      _selectedDistritos.remove(dist);
                  });
                },
              ),
            ),
            const Divider(),
            const Text(
              'Solo eventos gratuitos',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: const Text('Mostrar solo gratuitos'),
              value: _soloGratuitos,
              onChanged: (value) => setState(() => _soloGratuitos = value),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _savePrefs,
              child: const Text('Guardar preferencias'),
            ),
          ],
        ),
      ),
    );
  }
}
