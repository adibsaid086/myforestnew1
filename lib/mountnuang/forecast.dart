import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WeatherForecastPage extends StatefulWidget {
  @override
  _WeatherForecastPageState createState() => _WeatherForecastPageState();
}

class _WeatherForecastPageState extends State<WeatherForecastPage> {
  late Future<List<WeatherForecast>> forecast;

  @override
  void initState() {
    super.initState();
    forecast = fetchWeatherForecast();
  }

  @override
  Widget build(BuildContext context) {
    final darkTheme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF121212),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFF1E1E1E),
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white70),
      ),
      iconTheme: IconThemeData(color: Colors.white70),
    );


    return Theme(
      data: darkTheme,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Hulu Langat'),
        ),
        body: FutureBuilder<List<WeatherForecast>>(
          future: forecast,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text("No forecast data available"));
            } else {
              final weatherData = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "TODAY'S WEATHER",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        final forecast = weatherData[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Text(
                                forecast.time,
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                              Icon(Icons.cloud, color: Colors.white70),
                              Text(
                                '${forecast.temp}°C',
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '5-DAY FORECAST',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        final dailyForecast = weatherData[index * 8];
                        return ListTile(
                          leading: Icon(Icons.cloud, color: Colors.white70),
                          title: Text(
                            dailyForecast.dayName,
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Row(
                            children: [
                              Text('${dailyForecast.tempMin}°',
                                  style: TextStyle(color: Colors.white)),
                              SizedBox(width: 10),
                              Container(
                                height: 5,
                                width: 100,
                                color: Colors.orange,
                              ),
                              SizedBox(width: 10),
                              Text('${dailyForecast.tempMax}°',
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                          trailing: Text(
                            '${dailyForecast.precipitationChance}%',
                            style: TextStyle(color: Colors.white70),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}



class WeatherForecast {
  final String dayName;
  final String time;
  final String weatherDescription;
  final double temp;
  final double tempMax;
  final double tempMin;
  final int precipitationChance;

  WeatherForecast({
    required this.dayName,
    required this.time,
    required this.weatherDescription,
    required this.temp,
    required this.tempMax,
    required this.tempMin,
    required this.precipitationChance,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000).toLocal();
    final dayName = DateFormat('EEEE').format(dateTime); // Get the day name (e.g., "Monday")

    return WeatherForecast(
      dayName: dayName,
      time: dateTime.toString().split(' ')[1].substring(0, 5), // Get time in HH:MM format
      weatherDescription: json['weather'][0]['description'],
      temp: json['main']['temp'].toDouble(),
      tempMax: json['main']['temp_max'].toDouble(),
      tempMin: json['main']['temp_min'].toDouble(),
      precipitationChance: (json['pop'] * 100).toInt(),
    );
  }
}
Future<List<WeatherForecast>> fetchWeatherForecast() async {
  const String apiKey = '8f5b43dd3e53fb197df8ed5a8cae93c5';
  const String location = 'Hulu Langat';
  final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/forecast?q=$location&units=metric&appid=$apiKey');

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['list'];
      return data.map((json) => WeatherForecast.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load weather forecast');
    }
  } catch (e) {
    rethrow;
  }
}



