import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../helper/utils.dart';
import '../provider/weatherProvider.dart';

class HourlyScreen extends StatelessWidget {
  static const routeName = '/hourlyScreen';

  Widget dailyWidget(dynamic weather, BuildContext context) {
    final time = weather.date;
    final hours = DateFormat.Hm().format(time);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: Offset(2, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            hours ?? '',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          Spacer(),
          Text(
            '${weather.dailyTemp.toStringAsFixed(1)}°',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 15),
            child: MapString.mapStringToIcon(weather.condition, context, 25),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final weatherData = Provider.of<WeatherProvider>(context);
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text(
            'Next 24 Hours',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          height: mediaQuery.size.height,
          width: mediaQuery.size.width,
          child: ListView(
            children: weatherData.hourly24Weather
                .map((item) => dailyWidget(item, context))
                .toList(),
          ),
        ),
      ),
    );
  }
}
