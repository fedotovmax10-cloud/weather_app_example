import 'package:flutter/material.dart';
import 'package:flutter_worker/api/weather_api.dart';
import 'package:flutter_worker/screens/city_screen.dart';
import 'package:flutter_worker/widgets/bottom_list_view.dart';
import 'package:flutter_worker/widgets/city_view.dart';
import 'package:flutter_worker/models/weather_forecast_daily.dart';
import 'package:flutter_worker/widgets/detail_view.dart';
import 'package:flutter_worker/widgets/temp_view.dart';

class WeatherForecastScreen extends StatefulWidget {
  const WeatherForecastScreen({super.key, this.locationWeather});

  final WeatherForecast? locationWeather;

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  late Future<WeatherForecast> forecastObject;
  late String _cityName;
  // late String _cityName;

  @override
  void initState() {
    super.initState();

    if (widget.locationWeather != null) {
      forecastObject = Future.value(widget.locationWeather);
    }

    // forecastObject
    //     .then((weather) {
    //       print((weather.list![0].weather![0].main).toString());
    //     })
    //     .catchError((error) => print('Ошибка при загрузке: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          'openweathermap.org',
          style: const TextStyle(color: Colors.grey),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            setState(() {
              forecastObject = WeatherApi().fetchWeatherForecast();
            });
          },
          icon: Icon(Icons.my_location, color: Colors.grey),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              var tappedName = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CityScreen();
                  },
                ),
              );
              if (tappedName != null) {
                setState(() {
                  _cityName = tappedName;
                  forecastObject = WeatherApi().fetchWeatherForecast(
                    cityName: _cityName,
                    isCity: true,
                  );
                });
              }
            },
            icon: Icon(Icons.location_city, color: Colors.grey),
          ),
        ],
      ),
      body: ListView(
        children: [
          FutureBuilder<WeatherForecast>(
            future: forecastObject,
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    const SizedBox(height: 50),
                    CityView(snapshot: snapshot),
                    const SizedBox(height: 50),
                    TempView(snapshot: snapshot),
                    const SizedBox(height: 50),
                    DetailView(snapshot: snapshot),
                    const SizedBox(height: 50),
                    BottomListView(snapshot: snapshot),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return Center(
                  child: const Text(
                    'City not found\nPlease, enter correct city',
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
