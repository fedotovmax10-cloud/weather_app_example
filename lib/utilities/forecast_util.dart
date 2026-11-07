import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ForecastUtil {
  static String getFormattedDate(DateTime dateTime) {
    return DateFormat('EEE, MMM d, y').format(dateTime);
  }

  static Column getItem(FaIconData iconData, int value, String units) {
    return Column(
      children: [
        FaIcon(iconData, color: Colors.black87, size: 28),
        const SizedBox(height: 10),
        Text(
          '$value',
          style: const TextStyle(fontSize: 20, color: Colors.black87),
        ),
        const SizedBox(height: 10),
        Text(
          units,
          style: const TextStyle(fontSize: 15, color: Colors.black87),
        ),
      ],
    );
  }
}
