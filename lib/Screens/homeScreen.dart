import 'package:flutter/material.dart';
import 'package:flutter_weather/widgets/WeatherInfoHeader.dart';
import 'package:flutter_weather/widgets/mainWeatherDetail.dart';
import 'package:flutter_weather/widgets/mainWeatherInfo.dart';
import 'package:flutter_weather/widgets/twentyFourHourForecast.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: PhosphorIcon(
          PhosphorIcons.list(),
          size: 30.0,
        ),
        actions: [
          IconButton(
            icon: PhosphorIcon(
              PhosphorIcons.magnifyingGlass(),
              size: 30.0,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          WeatherInfoHeader(),
          const SizedBox(height: 16.0),
          MainWeatherInfo(),
          const SizedBox(height: 16.0),
          MainWeatherDetail(),
          const SizedBox(height: 16.0),
          TwentyFourHourForecast(),
        ],
      ),
    );
  }
}
