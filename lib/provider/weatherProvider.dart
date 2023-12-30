import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_weather/models/additionalWeatherData.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import '../models/dailyWeather.dart';
import '../models/weather.dart';

class WeatherProvider with ChangeNotifier {
  String apiKey = 'Enter Your API Key';
  late Weather weather;
  late AdditionalWeatherData additionalWeatherData;
  LatLng? currentLocation;
  List<DailyWeather> hourlyWeather = [];
  List<DailyWeather> fiveDayWeather = [];
  List<DailyWeather> sevenDayWeather = [];
  bool isLoading = false;
  bool isRequestError = false;
  bool isLocationError = false;
  bool serviceEnabled = false;
  LocationPermission? permission;
  bool isCelsius = true;

  String get measurementUnit => isCelsius ? '°C' : '°F';

  Future<Position>? requestLocation(BuildContext context) async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Location service disabled'),
      ));
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Permission denied'),
        ));
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Location permissions are permanently denied'),
      ));
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> getWeatherData(
    BuildContext context, {
    bool notify = false,
  }) async {
    isLoading = true;
    isRequestError = false;
    isLocationError = false;
    if (notify) notifyListeners();

    Position? locData = await requestLocation(context);
    if (locData == null) {
      isLocationError = true;
      notifyListeners();
      return;
    }

    try {
      currentLocation = LatLng(locData.latitude, locData.longitude);
      await getCurrentWeather(currentLocation!);
      await getDailyWeather(currentLocation!);
    } catch (e) {
      print(e);
      isLocationError = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getCurrentWeather(LatLng location) async {
    Uri url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&units=metric&appid=$apiKey',
    );
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      weather = Weather.fromJson(extractedData);
      print('Fetched Weather for: ${weather.city}/${weather.countryCode}');
    } catch (error) {
      print(error);
      isLoading = false;
      this.isRequestError = true;
    }
  }

  Future<void> getDailyWeather(LatLng location) async {
    isLoading = true;
    notifyListeners();

    Uri dailyUrl = Uri.parse(
      'https://api.openweathermap.org/data/2.5/onecall?lat=${location.latitude}&lon=${location.longitude}&units=metric&exclude=minutely,current&appid=$apiKey',
    );
    try {
      final response = await http.get(dailyUrl);
      final dailyData = json.decode(response.body) as Map<String, dynamic>;
      additionalWeatherData = AdditionalWeatherData.fromJson(dailyData);
      List dailyList = dailyData['daily'];
      List hourlyList = dailyData['hourly'];
      hourlyWeather = hourlyList
          .map((item) => DailyWeather.fromHourlyJson(item))
          .toList()
          .take(24)
          .toList();
      sevenDayWeather = dailyList
          .map((item) => DailyWeather.fromDailyJson(item))
          .toList()
          .skip(1)
          .take(7)
          .toList();
    } catch (error) {
      print(error);
      isLoading = false;
      this.isRequestError = true;
    }
  }

  Future<void> searchWeatherWithLocation(String location) async {
    Uri url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$location&units=metric&appid=$apiKey',
    );
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      weather = Weather.fromJson(extractedData);
    } catch (error) {
      print(error);
      this.isRequestError = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchWeather(String location) async {
    // isLoading = true;
    // notifyListeners();
    // isRequestError = false;
    // isLocationError = false;
    // await searchWeatherWithLocation(location);
    // if (weather == null) {
    //   isRequestError = true;
    //   notifyListeners();
    //   return;
    // }
    // await getDailyWeather(LatLng(weather!.lat, weather!.long));
  }

  void switchTempUnit() {
    isCelsius = !isCelsius;
    notifyListeners();
  }
}
