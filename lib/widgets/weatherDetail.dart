import 'package:flutter/material.dart';
import 'package:flutter_weather_icons/flutter_weather_icons.dart';

class WeatherDetail extends StatelessWidget {
  final wData;

  WeatherDetail({this.wData});

  Widget _gridWeatherBuilder(String header, String body, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(6, 8),
          ),
        ],
      ),
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15, right: 5),
            child: Icon(
              icon,
              color: Colors.blue,
              size: 35,
            ),
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                child: Text(
                  header,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              FittedBox(
                child: Text(
                  body,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            'Today Details',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          child: GridView(
            padding: EdgeInsets.all(15),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              childAspectRatio: 2 / 1,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            children: [
              _gridWeatherBuilder('${wData.weather.humidity}%', 'Humidity',
                  WeatherIcons.wiRaindrop),
              _gridWeatherBuilder('${wData.weather.windSpeed} km/h', 'Wind',
                  WeatherIcons.wiStrongWind),
              _gridWeatherBuilder(
                  '${wData.weather.feelsLike.toStringAsFixed(1)}°C',
                  'Feels Like',
                  WeatherIcons.wiCelsius),
              _gridWeatherBuilder('${wData.weather.pressure} hPa', 'Pressure',
                  WeatherIcons.wiBarometer),
            ],
          ),
        ),
      ],
    );
  }
}
