import 'package:flutter/material.dart';
import 'package:flutter_weather/models/dailyWeather.dart';
import 'package:flutter_weather/provider/weatherProvider.dart';
import 'package:flutter_weather/screens/sevenDayForecastScreen.dart';
import 'package:flutter_weather/theme/colors.dart';
import 'package:flutter_weather/theme/textStyle.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class SevenDayForecast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              PhosphorIcon(PhosphorIconsRegular.calendar),
              const SizedBox(width: 4.0),
              Text(
                '7-Day Forecast',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              TextButton(
                style: TextButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  textStyle: mediumText.copyWith(fontSize: 14.0),
                  foregroundColor: primaryBlue,
                ),
                child: Text('more details ▶'),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(SevenDayForecastDetail.routeName);
                },
              )
            ],
          ),
        ),
        Container(
          child: Consumer<WeatherProvider>(
            builder: (context, weatherProv, _) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: weatherProv.dailyWeather.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final DailyWeather weather = weatherProv.dailyWeather[index];
                  return Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                        color: index.isEven ? backgroundWhite : Colors.white,
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width / 4,
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text(
                              index == 0
                                  ? 'Today'
                                  : DateFormat('EEEE').format(weather.date),
                              style: semiboldText,
                              maxLines: 1,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Placeholder(
                              fallbackHeight: 24.0,
                              fallbackWidth: 24.0,
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              weather.condition ?? '',
                              style: lightText,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width / 5,
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text(
                              '${weather.tempMax.toStringAsFixed(0)}°/${weather.tempMin.toStringAsFixed(0)}°',
                              style: semiboldText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
