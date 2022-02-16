import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helper/utils.dart';
import '../models/dailyWeather.dart';

class SevenDayForecast extends StatelessWidget {
  final wData;
  final List<DailyWeather> dWeather;

  SevenDayForecast({this.wData, this.dWeather});

  Widget dailyWidget(dynamic weather, BuildContext context) {
    final dayOfWeek = DateFormat('EEE').format(weather.date);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 7),
      child: Column(
        children: [
          FittedBox(
            child: Text(
              dayOfWeek ?? '',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 20),
            child:
            MapString.mapStringToIcon('${weather.condition}', context, 35),
          ),
          Text(
            '${weather.condition}',
          ),
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
          padding: const EdgeInsets.only(top: 25, left: 20),
          child: Text(
            'Next 7 Days',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 3.5,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 0,
                blurRadius: 15,
                offset: Offset(6, 8),
              ),
            ],
          ),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        '${wData.weather.temp.toStringAsFixed(1)}°',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      MapString.mapInputToWeather(
                          '${wData.weather.currently}', context)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: MapString.mapStringToIcon(
                        '${wData.weather.currently}', context, 45),
                  ),
                ],
              ),
              SizedBox(height: 15),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: dWeather
                      .map((item) => dailyWidget(item, context))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
