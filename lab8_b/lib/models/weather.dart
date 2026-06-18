class Weather {
  final double temperature;
  final double windSpeed;

  Weather({
    required this.temperature,
    required this.windSpeed,
  });

  factory Weather.fromJson(
      Map<String, dynamic> json) {

    return Weather(
      temperature:
      json['current_weather']
      ['temperature']
          .toDouble(),

      windSpeed:
      json['current_weather']
      ['windspeed']
          .toDouble(),
    );
  }
}