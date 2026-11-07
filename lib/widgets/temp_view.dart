import 'package:flutter/material.dart';
import 'package:flutter_worker/models/weather_forecast_daily.dart';

class TempView extends StatelessWidget {
  const TempView({super.key, required this.snapshot});

  final AsyncSnapshot<WeatherForecast> snapshot;

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data?.list;
    var icon = forecastList![0].getIconUrl();
    var temp = forecastList[0].temp!.day!.toStringAsFixed(0);
    var description = forecastList[0].weather![0].description!.toUpperCase();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(icon, scale: 0.7, color: Colors.black87),
        const SizedBox(width: 20),
        Column(
          children: [
            Text(
              '$temp °C',
              style: const TextStyle(fontSize: 54, color: Colors.black87),
            ),
            Text(
              description,
              style: const TextStyle(fontSize: 18, color: Colors.black87),
            ),
          ],
        ),
      ],
    );
  }
}
