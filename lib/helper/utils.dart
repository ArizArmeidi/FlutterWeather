import 'package:flutter/material.dart';

String uviValueToString(int uvi) {
  if (uvi <= 2) {
  } else if (uvi <= 5) {
    return 'Medium';
  } else if (uvi <= 7) {
    return 'High';
  } else if (uvi <= 10) {
    return 'Very High';
  } else if (uvi >= 11) {
    return 'Extreme';
  }
  return 'Unknown';
}

class MapString {
  static Widget mapInputToWeather(BuildContext context, String input) {
    String text;
    switch (input) {
      case 'Tornado':
        text = 'Tornado';
        break;
      case 'Thunderstorm':
        text = 'Thunderstorm';
        break;
      case 'Drizzle':
        text = 'Drizzly';
        break;
      case 'Rain':
        text = 'Raining';
        break;
      case 'Snow':
        text = 'Snowing';
        break;
      case 'Mist':
        text = 'Misty';
        break;
      case 'fog':
        text = 'Foggy';
        break;
      case 'Smoke':
        text = 'Smoky';
        break;
      case 'Squall':
        text = 'Squally';
        break;
      case 'Haze':
        text = 'Hazy';
        break;
      case 'Dust':
        text = 'Dusty';
        break;
      case 'Sand':
        text = 'Sandy';
        break;
      case 'Ash':
        text = 'Ashy';
        break;
      case 'Clear':
        text = "Sunny";
        break;
      case 'Clouds':
        text = "Cloudy";
        break;
      default:
        text = "No Info";
    }
    return Text(
      text,
      style: TextStyle(
        fontSize: 15,
      ),
    );
  }

  static Icon mapStringToIcon(String input, double iconSize) {
    IconData icon;
    switch (input) {
      case 'Thunderstorm':
        icon = Icons.ac_unit;
        break;
      case 'Drizzle':
        icon = Icons.ac_unit;
        break;
      case 'Rain':
        icon = Icons.ac_unit;
        break;
      case 'Snow':
        icon = Icons.ac_unit;
        break;
      case 'Clear':
        icon = Icons.ac_unit;
        break;
      case 'Clouds':
        icon = Icons.ac_unit;
        break;
      case 'Mist':
        icon = Icons.ac_unit;
        break;
      case 'fog':
        icon = Icons.ac_unit;
        break;
      case 'Smoke':
        icon = Icons.ac_unit;
        break;
      case 'Haze':
        icon = Icons.ac_unit;
        break;
      case 'Dust':
      case 'Sand':
      case 'Ash':
        icon = Icons.ac_unit;
        break;
      case 'Squall':
      case 'Tornado':
        icon = Icons.ac_unit;
        break;
      default:
        icon = Icons.ac_unit;
    }
    return Icon(icon, size: iconSize, color: Colors.blue);
  }
}
