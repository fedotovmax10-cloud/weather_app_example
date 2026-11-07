import 'package:flutter/material.dart';
import 'package:flutter_worker/models/weather_forecast_daily.dart';
import 'package:flutter_worker/utilities/forecast_util.dart';

Widget forecastCard(AsyncSnapshot<WeatherForecast> snapshot, int index) {
  var forecastList = snapshot.data!.list;
  var dayOfWeek = '';
  DateTime date = DateTime.fromMillisecondsSinceEpoch(
    forecastList![index].dt! * 1000,
  );
  var fuulDate = ForecastUtil.getFormattedDate(date);
  dayOfWeek = fuulDate.split(',')[0];
  var tempMin = forecastList[index].temp!.min!.toStringAsFixed(0);
  var icon = forecastList[index].getIconUrl();
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            dayOfWeek,
            style: const TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6),
                    child: Text(
                      '$tempMin °C',
                      style: const TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                  Image.network(icon, scale: 1.2, color: Colors.white),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
