import 'package:flutter/material.dart';
import 'package:flutter_weather/provider/weatherProvider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class WeatherDetail extends StatelessWidget {
  Widget _gridWeatherBuilder(String header, String body, IconData icon) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(15),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.blue,
              size: 35,
            ),
            const SizedBox(width: 15.0),
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
      ),
    );
  }

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
                _gridWeatherBuilder('${weatherProv.weather!.humidity}%',
                    'Humidity', MdiIcons.waterPercent),
                _gridWeatherBuilder('${weatherProv.weather!.windSpeed} km/h',
                    'Wind', MdiIcons.weatherWindy),
                _gridWeatherBuilder(
                    '${weatherProv.weather!.feelsLike.toStringAsFixed(1)}°C',
                    'Feels Like',
                    MdiIcons.temperatureCelsius),
                _gridWeatherBuilder('${weatherProv.weather!.pressure} hPa',
                    'Pressure', MdiIcons.arrowDownCircle),
              ],
            ),
          ),
        ],
      );
    });
  }
}
