import 'package:flutter/material.dart';
import 'package:flutter_worker/models/weather_forecast_daily.dart';
import 'package:flutter_worker/utilities/forecast_util.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailView extends StatelessWidget {
  const DetailView({super.key, required this.snapshot});

  final AsyncSnapshot<WeatherForecast> snapshot;

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data!.list;
    var pressure = forecastList![0].pressure! * 0.750062;
    var humidity = forecastList[0].humidity!;
    var wind = forecastList[0].speed!;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ForecastUtil.getItem(
          // ignore: deprecated_member_use
          FontAwesomeIcons.thermometerThreeQuarters,
          pressure.round(),
          'mm Hg',
        ),
        ForecastUtil.getItem(FontAwesomeIcons.cloudRain, humidity, '%'),
        ForecastUtil.getItem(FontAwesomeIcons.wind, wind.toInt(), 'm/s'),
      ],
    );
  }
}
