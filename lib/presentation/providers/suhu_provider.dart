import 'package:flutter/material.dart';
import '../../domain/usecase/convert_temperature.dart';

class SuhuProvider extends ChangeNotifier {
  final ConvertTemperature converter = ConvertTemperature();

  String satuanInput = 'Celcius';
  String input = '';

  double? celcius;
  double? fahrenheit;
  double? kelvin;
  double? reamur;

  void setInput(String value) {
    input = value;
    hitung();
  }

  void setSatuan(String value) {
    satuanInput = value;
    hitung();
  }

  void hitung() {
    if (input.isEmpty) {
      clear();
      return;
    }

    double? nilai = double.tryParse(input);

    if (nilai == null) {
      clear();
      return;
    }

    double c = converter.toCelcius(nilai, satuanInput);

    celcius = c;
    fahrenheit = (c * 9 / 5) + 32;
    kelvin = c + 273.15;
    reamur = c * 4 / 5;

    notifyListeners();
  }

  void clear() {
    celcius = null;
    fahrenheit = null;
    kelvin = null;
    reamur = null;
    notifyListeners();
  }

  String format(double? nilai) {
    if (nilai == null) return '-';
    return nilai.toStringAsFixed(1);
  }
}