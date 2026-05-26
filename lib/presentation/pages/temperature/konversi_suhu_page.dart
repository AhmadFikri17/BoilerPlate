import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/suhu_provider.dart';
import '../../widgets/hasil_item.dart';

class KonversiSuhuPage extends StatelessWidget {
  const KonversiSuhuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final suhu = context.watch<SuhuProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Konversi Suhu'),
        actions: [
          IconButton(
            onPressed: () async {
              // Menjalankan fungsi logout Firebase.
              // Setelah berhasil, StreamBuilder di main.dart akan mendeteksi status
              // user menjadi null dan otomatis memindahkan layar ke LoginPage.
              await context.read<AuthProvider>().logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              decoration: const InputDecoration(
                labelText: 'Masukkan suhu',
                border: OutlineInputBorder(),
              ),
              onChanged: suhu.setInput,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: suhu.satuanInput,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: ['Celcius', 'Fahrenheit', 'Kelvin', 'Reamur']
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: (v) => suhu.setSatuan(v!),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  HasilItem(
                    title: 'Celcius',
                    value: suhu.format(suhu.celcius),
                    unit: '°C',
                  ),
                  HasilItem(
                    title: 'Fahrenheit',
                    value: suhu.format(suhu.fahrenheit),
                    unit: '°F',
                  ),
                  HasilItem(
                    title: 'Kelvin',
                    value: suhu.format(suhu.kelvin),
                    unit: 'K',
                  ),
                  HasilItem(
                    title: 'Reamur',
                    value: suhu.format(suhu.reamur),
                    unit: '°R',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}