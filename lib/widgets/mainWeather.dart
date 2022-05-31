import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../helper/utils.dart';

class MainWeather extends StatelessWidget {
  final wData;

  MainWeather({this.wData});

  final TextStyle _style1 = TextStyle(
      fontWeight: FontWeight.w700, fontSize: 20, color: Color(0xFFF2FDFC));
  final TextStyle _style2 = TextStyle(
    fontWeight: FontWeight.w400,
    color: Colors.white,
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Color(0xFF142B37),
      ),
      padding: EdgeInsets.fromLTRB(25, 15, 25, 5),
      height: MediaQuery.of(context).size.height / 3.4,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Colors.white,
              ),
              Text('${wData.weather.cityName}', style: _style1),
            ],
          ),
          SizedBox(height: 5),
          Text(
            DateFormat.yMMMEd().add_jm().format(DateTime.now()),
            style: _style2,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 25, right: 25),
                child: MapString.mapStringToIcon(
                    '${wData.weather.currently}', context, 55),
              ),
              Text(
                '${wData.weather.temp.toStringAsFixed(0)}°C',
                style: TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            '${wData.weather.tempMax.toStringAsFixed(0)}°/ ${wData.weather.tempMin.toStringAsFixed(0)}° Feels like ${wData.weather.feelsLike.toStringAsFixed(0)}°',
            style: _style1.copyWith(fontSize: 19),
          ),
          SizedBox(height: 5),
          Text(
            toBeginningOfSentenceCase('${wData.weather.description}'),
            style: _style1.copyWith(fontSize: 19),
          ),
        ],
      ),
    );
  }
}
