import 'package:flutter/material.dart';
import 'package:flutter_weather/provider/weatherProvider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../helper/utils.dart';

class WeatherInfo extends StatelessWidget {
  Widget _weatherInfoBuilder({
    required String header,
    required String body,
    required IconData icon,
    double? iconSize,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.blue,
          size: iconSize ?? 40,
        ),
        const SizedBox(width: 16.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: Text(
                header,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
              ),
            ),
            FittedBox(
              child: Text(
                body,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(builder: (context, weatherProv, _) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _weatherInfoBuilder(
                header: 'Precipitation',
                body: '${weatherProv.currentWeather.precip}%',
                icon: MdiIcons.weatherRainy,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                height: 65.0,
                child: VerticalDivider(
                  color: Colors.black,
                  indent: 10.0,
                  endIndent: 10.0,
                ),
              ),
              _weatherInfoBuilder(
                header: 'UV Index',
                body: UvIndex.mapUviValueToString(
                    uvi: weatherProv.currentWeather.uvi),
                icon: MdiIcons.sunWireless,
              ),
            ],
          ),
        ),
      );
    });
  }
}
