import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Util {
  static String getFormattedBaseDate(DateTime dateTime) {
    return DateFormat('EEE, MMM d, y').format(dateTime);
  }

  static String getFormattedDate(DateTime dateTime) {
    return DateFormat('d MMM y').format(dateTime);
  }

  static getItem(IconData iconData, int value, String units) {
    return Column(
      children: [
        Icon(iconData, size: 50, color: Colors.white),
        Text('$value',
            style: const TextStyle(fontSize: 35, color: Colors.white)),
        Text(units, style: const TextStyle(fontSize: 25, color: Colors.white)),
      ],
    );
  }
}
