import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService service = WeatherService();

  final TextEditingController cityController =
  TextEditingController(text: "Hanoi");

  late Future<Weather> futureWeather;

  String currentCity = "Hanoi";

  @override
  void initState() {
    super.initState();

    futureWeather =
        service.fetchWeatherByCity(currentCity);
  }

  void searchWeather() {
    if (cityController.text.trim().isEmpty) {
      return;
    }

    setState(() {
      currentCity = cityController.text.trim();

      futureWeather =
          service.fetchWeatherByCity(currentCity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Companion"),
      ),

      body: Column(
        children: [

          // SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(16),

            child: Row(
              children: [

                Expanded(
                  child: TextField(
                    controller: cityController,

                    decoration: const InputDecoration(
                      labelText: "Enter City",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                ElevatedButton(
                  onPressed: searchWeather,
                  child: const Text("Search"),
                ),
              ],
            ),
          ),

          // WEATHER DATA
          Expanded(
            child: FutureBuilder<Weather>(
              future: futureWeather,

              builder: (context, snapshot) {

                if (snapshot.connectionState ==
                    ConnectionState.waiting) {

                  return const Center(
                    child:
                    CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {

                  return Center(
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,

                      children: [

                        Text(
                          snapshot.error.toString(),
                        ),

                        const SizedBox(height: 10),

                        ElevatedButton(
                          onPressed:
                          searchWeather,
                          child:
                          const Text("Retry"),
                        ),
                      ],
                    ),
                  );
                }

                Weather weather =
                snapshot.data!;

                String recommendation;

                if (weather.temperature > 35) {

                  recommendation =
                  "Too hot for outdoor sports";

                } else if (weather.temperature < 20) {

                  recommendation =
                  "Bring a jacket";

                } else {

                  recommendation =
                  "Nice weather for a walk";
                }

                return Padding(
                  padding:
                  const EdgeInsets.all(16),

                  child: ListView(
                    children: [

                      Center(
                        child: Text(
                          currentCity,
                          style:
                          const TextStyle(
                            fontSize: 28,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.thermostat,
                          ),

                          title: const Text(
                            "Temperature",
                          ),

                          subtitle: Text(
                            "${weather.temperature} °C",
                          ),
                        ),
                      ),

                      Card(
                        child: ListTile(
                          leading:
                          const Icon(Icons.air),

                          title:
                          const Text(
                            "Wind Speed",
                          ),

                          subtitle: Text(
                            "${weather.windSpeed} km/h",
                          ),
                        ),
                      ),

                      Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.lightbulb,
                          ),

                          title:
                          const Text(
                            "Recommendation",
                          ),

                          subtitle: Text(
                            recommendation,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}