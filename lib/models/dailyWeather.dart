// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

class DailyWeather with ChangeNotifier {
  final double temp;
  final double tempMin;
  final double tempMax;
  final String? condition;
  final DateTime date;
  final String? precipitation;
  final int? uvi;

  DailyWeather({
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    this.condition,
    required this.date,
    this.precipitation,
    this.uvi,
  });

  static DailyWeather fromDailyJson(dynamic json) {
    return DailyWeather(
      temp: (json['temp']['day']).toDouble(),
      tempMin: (json['temp']['min']).toDouble(),
      tempMax: (json['temp']['max']).toDouble(),
      condition: json['weather'][0]['main'],
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true),
    );
  }
}
