import 'package:flutter/material.dart';
import 'package:flutter_worker/models/weather_forecast_daily.dart';
import 'package:flutter_worker/widgets/forecast_card.dart';

class BottomListView extends StatelessWidget {
  const BottomListView({super.key, required this.snapshot});

  final AsyncSnapshot<WeatherForecast> snapshot;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '7-Day Weather Forecast'.toUpperCase(),
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 140,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemCount: snapshot.data!.list!.length,
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width / 2.7,
                height: 160,
                color: Colors.black87,
                child: forecastCard(snapshot, index),
              );
            },
          ),
        ),
      ],
    );
  }
}
