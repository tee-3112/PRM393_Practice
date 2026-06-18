import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherService {

  Future<Weather> fetchWeatherByCity(
      String city) async {

    final geoResponse = await http.get(
      Uri.parse(
        "https://geocoding-api.open-meteo.com/v1/search?name=$city",
      ),
    );

    final geoData =
    jsonDecode(geoResponse.body);

    if (geoData["results"] == null) {

      throw Exception(
        "City not found",
      );
    }

    double latitude =
    geoData["results"][0]["latitude"];

    double longitude =
    geoData["results"][0]["longitude"];

    final weatherResponse =
    await http.get(
      Uri.parse(
        "https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current_weather=true",
      ),
    );

    if (weatherResponse.statusCode == 200) {

      return Weather.fromJson(
        jsonDecode(
          weatherResponse.body,
        ),
      );
    }

    throw Exception(
      "Failed to load weather",
    );
  }
}