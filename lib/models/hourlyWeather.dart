// ignore_for_file: public_member_api_docs, sort_constructors_first
class HourlyWeather {
  final double temp;
  final String? condition;
  final DateTime date;
  HourlyWeather({
    required this.temp,
    this.condition,
    required this.date,
  });

  static HourlyWeather fromJson(dynamic json) {
    return HourlyWeather(
      temp: (json['temp']).toDouble(),
      condition: json['weather'][0]['main'],
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
    );
  }
}
