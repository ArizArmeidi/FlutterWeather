import 'package:flutter/material.dart';
import 'package:flutter_weather/provider/weatherProvider.dart';
import 'package:flutter_weather/widgets/WeatherInfoHeader.dart';
import 'package:flutter_weather/widgets/mainWeatherDetail.dart';
import 'package:flutter_weather/widgets/mainWeatherInfo.dart';
import 'package:flutter_weather/widgets/sevenDayForecast.dart';
import 'package:flutter_weather/widgets/twentyFourHourForecast.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    requestWeather();
  }

  Future<void> requestWeather() async {
    await Provider.of<WeatherProvider>(context, listen: false)
        .getWeatherData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: PhosphorIcon(
          PhosphorIcons.list(),
          size: 30.0,
        ),
        actions: [
          SearchAnchor(
            builder: (context, controller) => IconButton(
              icon: PhosphorIcon(
                PhosphorIcons.magnifyingGlass(),
                size: 30.0,
              ),
              onPressed: () {
                controller.openView();
              },
            ),
            suggestionsBuilder: (context, controller) {
              List<String> searchSuggestion = [
                'London',
                'New York',
                'Tokyo',
                'Jakarta',
                'Dubai',
              ];
              return searchSuggestion
                  .map(
                    (item) => ListTile(
                      title: Text(item),
                      onTap: () {
                        setState(() {
                          controller.closeView(item);
                        });
                      },
                    ),
                  )
                  .toList();
            },
          )
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(12.0),
        children: [
          WeatherInfoHeader(),
          const SizedBox(height: 16.0),
          MainWeatherInfo(),
          const SizedBox(height: 16.0),
          MainWeatherDetail(),
          const SizedBox(height: 16.0),
          TwentyFourHourForecast(),
          const SizedBox(height: 16.0),
          SevenDayForecast(),
        ],
      ),
    );
  }
}
