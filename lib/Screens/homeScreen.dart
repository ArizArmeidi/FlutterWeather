import 'package:flutter/material.dart';
import 'package:flutter_weather/provider/weatherProvider.dart';
import 'package:flutter_weather/theme/colors.dart';
import 'package:flutter_weather/theme/textStyle.dart';
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
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProv, _) {
          if (weatherProv.isRequestError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Search Error',
                    style: semiboldText,
                  ),
                ),
              ],
            );
          }
          return Stack(
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
              CustomSearchBar(),
            ],
          );
        },
      ),
    );
  }
}

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  FloatingSearchBarController _fsc = FloatingSearchBarController();

  List<String> _citiesSuggestion = [
    'New York',
    'Tokyo',
    'Dubai',
    'London',
    'Singapore',
    'Sydney',
    'Wellington'
  ];

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      controller: _fsc,
      hint: 'Search...',
      clearQueryOnClose: false,
      scrollPadding: const EdgeInsets.only(top: 16.0, bottom: 56.0),
      transitionDuration: const Duration(milliseconds: 400),
      borderRadius: BorderRadius.circular(16.0),
      transitionCurve: Curves.easeInOut,
      accentColor: primaryBlue,
      hintStyle: regularText,
      queryStyle: regularText,
      physics: const BouncingScrollPhysics(),
      elevation: 2.0,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {},
      onSubmitted: (query) async {
        _fsc.close();
        await Provider.of<WeatherProvider>(context, listen: false)
            .searchWeather(query);
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: PhosphorIcon(
            PhosphorIconsBold.magnifyingGlass,
            color: primaryBlue,
          ),
        ),
        FloatingSearchBarAction.icon(
          showIfClosed: false,
          showIfOpened: true,
          icon: PhosphorIcon(
            PhosphorIconsBold.x,
            color: primaryBlue,
          ),
          onTap: () {
            if (_fsc.query.isEmpty) {
              _fsc.close();
            } else {
              _fsc.clear();
            }
          },
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: ListView.separated(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: _citiesSuggestion.length,
              itemBuilder: (context, index) {
                String data = _citiesSuggestion[index];
                return InkWell(
                  onTap: () async {
                    _fsc.query = data;
                    _fsc.close();
                    await Provider.of<WeatherProvider>(context, listen: false)
                        .searchWeather(data);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(22.0),
                    child: Row(
                      children: [
                        PhosphorIcon(PhosphorIconsFill.mapPin),
                        const SizedBox(width: 22.0),
                        Text(data, style: mediumText),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(
                thickness: 1.0,
                height: 0.0,
              ),
            ),
          ),
        );
      },
    );
  }
}
