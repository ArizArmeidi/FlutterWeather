import 'package:flutter/material.dart';
import 'package:flutter_weather/provider/weatherProvider.dart';
import 'package:provider/provider.dart';

class WeatherDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(builder: (context, weatherProv, _) {
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
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              children: [
                // _gridWeatherBuilder('${weatherProv.weather!.humidity}%',
                //     'Humidity', MdiIcons.waterPercent),
                // _gridWeatherBuilder('${weatherProv.weather!.windSpeed} km/h',
                //     'Wind', MdiIcons.weatherWindy),
                // _gridWeatherBuilder(
                //     '${weatherProv.weather!.feelsLike.toStringAsFixed(1)}°C',
                //     'Feels Like',
                //     MdiIcons.temperatureCelsius),
                // _gridWeatherBuilder('${weatherProv.weather!.pressure} hPa',
                //     'Pressure', MdiIcons.arrowDownCircle),
              ],
            ),
          ),
        ],
      );
    });
  }
}
