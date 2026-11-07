import 'dart:convert';

import 'package:flutter_worker/utilities/location.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_worker/models/weather_forecast_daily.dart';
import 'package:flutter_worker/utilities/constants.dart';

class WeatherApi {
  Future<WeatherForecast> fetchWeatherForecast({
    String? cityName,
    bool? isCity,
  }) async {
    Map<String, String?> parameters;

    if (isCity == true) {
      var queryParameters = {
        'APPID': Constants.WEATHER_APP_ID,
        'units': 'metric',
        'q': cityName,
      };
      parameters = queryParameters;
    } else {
      Location location = Location();
      await location.getCurrentLocation();
      var queryParameters = {
        'APPID': Constants.WEATHER_APP_ID,
        'units': 'metric',
        'lat': location.latitude.toString(),
        'lon': location.longtitude.toString(),
      };
      parameters = queryParameters;
    }

    var uri = Uri.https(
      Constants.WEATHER_BASE_URL_DOMAIN,
      Constants.WEATHER_FORECAST_PATH,
      parameters,
    );

    print('request: ${uri.toString()}');

    var response = await http
        .get(uri)
        .timeout(
          const Duration(seconds: 10),
          onTimeout: () => throw Exception('Превышено время ожидания'),
        );

    print('response: ${response.body}');

    if (response.statusCode == 200) {
      return WeatherForecast.fromJson(json.decode(response.body));
    } else {
      return Future.error('Error response');
    }
  }
}
