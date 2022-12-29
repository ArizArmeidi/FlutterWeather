import 'package:flutter/cupertino.dart';

class DailyWeather with ChangeNotifier {
  final dynamic dailyTemp;
  final String? condition;
  final DateTime? date;
  final String? precip;
  final int? uvi;

  DailyWeather({
    this.dailyTemp,
    this.condition,
    this.date,
    this.precip,
    this.uvi,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    final precipData = json['daily'][0]['pop'];
    final calcPrecip = precipData * 100;
    final precipitation = calcPrecip.toStringAsFixed(0);
    return DailyWeather(
      precip: precipitation,
      uvi: (json['daily'][0]['uvi']).toInt(),
    );
  }

  static DailyWeather fromDailyJson(dynamic json) {
    return DailyWeather(
      dailyTemp: json['temp']['day'],
      condition: json['weather'][0]['main'],
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true),
    );
  }

  static DailyWeather fromHourlyJson(dynamic json) {
    return DailyWeather(
      dailyTemp: json['temp'],
      condition: json['weather'][0]['main'],
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
    );
  }
}
