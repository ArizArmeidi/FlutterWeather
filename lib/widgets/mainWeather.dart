import 'package:flutter/material.dart';
import 'package:flutter_weather/provider/weatherProvider.dart';
import 'package:flutter_weather/theme/textStyle.dart';
import 'package:provider/provider.dart';

class MainWeatherInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(builder: (context, weatherProv, _) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '23',
                        style: boldText.copyWith(fontSize: 86),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          '°C',
                          style: mediumText.copyWith(fontSize: 26),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Weather Condition',
                  style: lightText.copyWith(fontSize: 16),
                )
              ],
            ),
            Spacer(),
            Placeholder(
              fallbackHeight: 150,
              fallbackWidth: 200,
            )
          ],
        ),
      );
    });
  }
}
