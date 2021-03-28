import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helper/utils.dart';
import '../Screens/hourlyWeatherScreen.dart';
import '../models/dailyWeather.dart';

class HourlyForecast extends StatelessWidget {
  final List<DailyWeather> hourlyForecast;

  HourlyForecast(this.hourlyForecast);

  Widget hourlyWidget(dynamic weather, BuildContext context) {
    final currentTime = weather.date;
    final hours = DateFormat.Hm().format(currentTime);

    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(6, 8),
          ),
        ],
      ),
      height: 175,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  hours,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: MapString.mapStringToIcon(
                      '${weather.condition}', context, 40),
                ),
                Container(
                  width: 80,
                  child: Text(
                    "${weather.dailyTemp.toStringAsFixed(1)}°C",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  'Next 3 Hours',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                child: Text(
                  'See More',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(HourlyScreen.routeName);
                },
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: hourlyForecast
                  .map((item) => hourlyWidget(item, context))
                  .toList()),
        ],
      ),
    );
  }
}
