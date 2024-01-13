import 'package:flutter/material.dart';
import 'package:flutter_weather/provider/weatherProvider.dart';
import 'package:flutter_weather/widgets/WeatherInfoHeader.dart';
import 'package:flutter_weather/widgets/mainWeatherDetail.dart';
import 'package:flutter_weather/widgets/mainWeatherInfo.dart';
import 'package:flutter_weather/widgets/sevenDayForecast.dart';
import 'package:flutter_weather/widgets/twentyFourHourForecast.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FloatingSearchBarController _fsc = FloatingSearchBarController();
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
      // appBar: AppBar(
      //   leading: PhosphorIcon(
      //     PhosphorIcons.list(),
      //     size: 30.0,
      //   ),
      //   actions: [
      //     IconButton(
      //       icon: PhosphorIcon(
      //         PhosphorIcons.magnifyingGlass(),
      //         size: 30.0,
      //       ),
      //       splashRadius: 24,
      //       onPressed: () {
      //         // _fsc.show();
      //       },
      //     ),
      //   ],
      // ),
      body: Stack(
        children: [
          ListView(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.all(12.0).copyWith(top: 96.0),
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
          FloatingSearchBar(
            controller: _fsc,
            hint: 'Search...',
            scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
            transitionDuration: const Duration(milliseconds: 400),
            borderRadius: BorderRadius.circular(32.0),
            transitionCurve: Curves.easeInOut,
            physics: const BouncingScrollPhysics(),
            elevation: 4.0,
            debounceDelay: const Duration(milliseconds: 500),
            onQueryChanged: (query) {},
            transition: CircularFloatingSearchBarTransition(),
            actions: [
              FloatingSearchBarAction(
                showIfOpened: false,
                child: CircularButton(
                  icon: const Icon(Icons.place),
                  onPressed: () {},
                ),
              ),
              FloatingSearchBarAction.searchToClear(showIfClosed: false),
            ],
            builder: (context, transition) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Material(
                  color: Colors.white,
                  elevation: 4.0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: Colors.accents.map((color) {
                      return Container(height: 112, color: color);
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
