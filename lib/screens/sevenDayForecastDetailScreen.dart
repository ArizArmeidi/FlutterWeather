// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_weather/helper/extensions.dart';
import 'package:flutter_weather/provider/weatherProvider.dart';
import 'package:flutter_weather/theme/colors.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';

import '../helper/utils.dart';
import '../models/dailyWeather.dart';
import '../theme/textStyle.dart';

class SevenDayForecastDetail extends StatefulWidget {
  static const routeName = '/sevenDayForecast';
  final int initialIndex;

  const SevenDayForecastDetail({
    Key? key,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<SevenDayForecastDetail> createState() => _SevenDayForecastDetailState();
}

class _SevenDayForecastDetailState extends State<SevenDayForecastDetail> {
  int _selectedIndex = 0;
  late final ScrollController _scrollController;
  static const double _itemWidth = 24.0;
  static const double _horizontalPadding = 12.0;
  static const double _selectedWidth = 24.0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _scrollController = ScrollController();
    double _position = _selectedIndex * (_itemWidth + 2 * _horizontalPadding) +
        (_selectedWidth + _horizontalPadding);
    if (_selectedIndex > 1)
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _position,
          duration: Duration(milliseconds: 250),
          curve: Curves.ease,
        );
      });
  }

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
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProv, _) {
          DailyWeather _selectedWeather =
              weatherProv.dailyWeather[_selectedIndex];
          return ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            children: [
              const SizedBox(height: 12.0),
              SizedBox(
                height: 98.0,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  controller: _scrollController,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: weatherProv.dailyWeather.length,
                  itemBuilder: (context, index) {
                    final DailyWeather weather =
                        weatherProv.dailyWeather[index];
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
                        child: Row(
                          children: [
                            Column(
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
                                    weatherProv.isCelsius
                                        ? '${weather.tempMax.toStringAsFixed(0)}°/${weather.tempMin.toStringAsFixed(0)}°'
                                        : '${weather.tempMax.toFahrenheit().toStringAsFixed(0)}°/${weather.tempMin.toFahrenheit().toStringAsFixed(0)}°',
                                    style: regularText,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                        weatherProv.isCelsius
                            ? '${_selectedWeather.tempMax.toStringAsFixed(0)}°/${_selectedWeather.tempMin.toStringAsFixed(0)}°'
                            : '${_selectedWeather.tempMax.toFahrenheit().toStringAsFixed(0)}°/${_selectedWeather.tempMin.toFahrenheit().toStringAsFixed(0)}°',
                        style: boldText.copyWith(fontSize: 48.0, height: 1.15),
                      ),
                      Text(
                        _selectedWeather.weatherCategory,
                        style: semiboldText.copyWith(color: primaryBlue),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 112.0,
                    width: 112.0,
                    child: Image.asset(
                      getWeatherImage(_selectedWeather.weatherCategory),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Weather Condition',
                    style: semiboldText.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 12.0,
                    ),
                    decoration: BoxDecoration(
                      color: backgroundWhite,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: GridView(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 16 / 4,
                        crossAxisCount: 2,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 8,
                      ),
                      children: [
                        _ForecastDetailInfoTile(
                          title: 'Cloudiness',
                          icon: PhosphorIcon(
                            PhosphorIconsRegular.cloud,
                            color: Colors.white,
                          ),
                          data: '${_selectedWeather.clouds}%',
                        ),
                        _ForecastDetailInfoTile(
                          title: 'UV Index',
                          icon: PhosphorIcon(
                            PhosphorIconsRegular.sun,
                            color: Colors.white,
                          ),
                          data: uviValueToString(_selectedWeather.uvi),
                        ),
                        _ForecastDetailInfoTile(
                          title: 'Precipitation',
                          icon: PhosphorIcon(
                            PhosphorIconsRegular.drop,
                            color: Colors.white,
                          ),
                          data: _selectedWeather.precipitation + '%',
                        ),
                        _ForecastDetailInfoTile(
                          title: 'Humidity',
                          icon: PhosphorIcon(
                            PhosphorIconsRegular.thermometerSimple,
                            color: Colors.white,
                          ),
                          data: '${_selectedWeather.humidity}%',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Feels Like',
                    style: semiboldText.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 12.0,
                    ),
                    decoration: BoxDecoration(
                      color: backgroundWhite,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: GridView(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 16 / 4,
                        crossAxisCount: 2,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 8,
                      ),
                      children: [
                        _ForecastDetailInfoTile(
                          title: 'Morning Temp',
                          icon: PhosphorIcon(
                            PhosphorIconsRegular.thermometerSimple,
                            color: Colors.white,
                          ),
                          data: weatherProv.isCelsius
                              ? '${_selectedWeather.tempMorning.toStringAsFixed(1)}°'
                              : '${_selectedWeather.tempMorning.toFahrenheit().toStringAsFixed(1)}°',
                        ),
                        _ForecastDetailInfoTile(
                          title: 'Day Temp',
                          icon: PhosphorIcon(
                            PhosphorIconsRegular.thermometerSimple,
                            color: Colors.white,
                          ),
                          data: weatherProv.isCelsius
                              ? '${_selectedWeather.tempDay.toStringAsFixed(1)}°'
                              : '${_selectedWeather.tempDay.toFahrenheit().toStringAsFixed(1)}°',
                        ),
                        _ForecastDetailInfoTile(
                          title: 'Evening Temp',
                          icon: PhosphorIcon(
                            PhosphorIconsRegular.thermometerSimple,
                            color: Colors.white,
                          ),
                          data: weatherProv.isCelsius
                              ? '${_selectedWeather.tempEvening.toStringAsFixed(1)}°'
                              : '${_selectedWeather.tempEvening.toFahrenheit().toStringAsFixed(1)}°',
                        ),
                        _ForecastDetailInfoTile(
                          title: 'Night Temp',
                          icon: PhosphorIcon(
                            PhosphorIconsRegular.thermometerSimple,
                            color: Colors.white,
                          ),
                          data: weatherProv.isCelsius
                              ? '${_selectedWeather.tempNight.toStringAsFixed(1)}°'
                              : '${_selectedWeather.tempNight.toFahrenheit().toStringAsFixed(1)}°',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ForecastDetailInfoTile extends StatelessWidget {
  final String title;
  final String data;
  final Widget icon;
  const _ForecastDetailInfoTile({
    Key? key,
    required this.title,
    required this.data,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(backgroundColor: primaryBlue, child: icon),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(child: Text(title, style: lightText)),
              FittedBox(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 1.0),
                  child: Text(
                    data,
                    style: mediumText,
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
