import 'package:flutter/material.dart';
import 'package:flutter_weather/provider/weatherProvider.dart';
import 'package:flutter_weather/theme/colors.dart';
import 'package:flutter_weather/theme/textStyle.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class TwentyFourHourForecast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Row(
              children: [
                PhosphorIcon(PhosphorIconsRegular.clock),
                const SizedBox(width: 4.0),
                Text(
                  '24-Hour Forecast',
                  style: semiboldText.copyWith(fontSize: 16),
                ),
              ],
            ),
          ),
          Consumer<WeatherProvider>(builder: (context, weatherProv, _) {
            return SizedBox(
              height: 128.0,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => HourlyWeather(index),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class HourlyWeather extends StatelessWidget {
  final int index;
  const HourlyWeather(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      child: Column(
        children: [
          Text(
            '99',
            style: semiboldText,
          ),
          Stack(
            children: [
              Divider(
                thickness: 2.0,
                color: primaryBlue,
              ),
              if (index == 0)
                Positioned(
                  top: 2.0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      shape: BoxShape.circle,
                    ),
                  ),
                )
            ],
          ),
          Container(
            height: 42.0,
            width: 42.0,
            color: primaryBlue,
          ),
          Text(
            'Time',
            style: lightText,
          ),
          const SizedBox(height: 2.0),
          Text(
            'Time',
            style: regularText,
          )
        ],
      ),
    );
  }
}
