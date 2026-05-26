class ConvertTemperature {
  double toCelcius(double value, String from) {
    switch (from) {
      case 'Celcius':
        return value;

      case 'Fahrenheit':
        return (value - 32) * 5 / 9;

      case 'Kelvin':
        return value - 273.15;

      case 'Reamur':
        return value * 5 / 4;

      default:
        return value;
    }
  }
}