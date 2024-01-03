import 'package:flutter/material.dart';
import 'package:flutter_weather/provider/weatherProvider.dart';
import 'package:flutter_weather/theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../helper/utils.dart';
import '../models/dailyWeather.dart';
import '../theme/textStyle.dart';

class SevenDayForecastDetail extends StatefulWidget {
  static const routeName = '/sevenDayForecast';

  @override
  State<SevenDayForecastDetail> createState() => _SevenDayForecastDetailState();
}

class _SevenDayForecastDetailState extends State<SevenDayForecastDetail> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          '7-Day Forecast',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Consumer<WeatherProvider>(builder: (context, weatherProv, _) {
        DailyWeather _selectedWeather =
            weatherProv.dailyWeather[_selectedIndex];
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          children: [
            const SizedBox(height: 12.0),
            SizedBox(
              height: 98.0,
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(width: 8.0),
                scrollDirection: Axis.horizontal,
                itemCount: weatherProv.dailyWeather.length,
                itemBuilder: (context, index) {
                  final DailyWeather weather = weatherProv.dailyWeather[index];
                  bool isSelected = index == _selectedIndex;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: Container(
                      constraints: BoxConstraints(minWidth: 64.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? backgroundBlue
                            : backgroundBlue.withOpacity(.2),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            index == 0
                                ? 'Today'
                                : DateFormat('EEE').format(weather.date),
                            style: mediumText,
                            maxLines: 1,
                          ),
                          SizedBox(
                            height: 36.0,
                            width: 36.0,
                            child: Image.asset(
                              getWeatherImage(weather.weatherCategory),
                              fit: BoxFit.cover,
                            ),
                          ),
                          FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text(
                              '${weather.tempMax.toStringAsFixed(0)}°/${weather.tempMin.toStringAsFixed(0)}°',
                              style: regularText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _selectedIndex == 0
                      ? 'Today'
                      : DateFormat('EEEE').format(_selectedWeather.date),
                  style: mediumText,
                  maxLines: 1,
                ),
                Text(
                  '${_selectedWeather.tempMax.toStringAsFixed(0)}°/${_selectedWeather.tempMin.toStringAsFixed(0)}°',
                  style: boldText.copyWith(fontSize: 48.0, height: 1.15),
                ),
                Text(
                  _selectedWeather.weatherCategory,
                  style: semiboldText.copyWith(color: primaryBlue),
                )
              ],
            )
          ],
        );
      }),
    );
  }
}
