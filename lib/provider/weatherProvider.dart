import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import '../models/dailyWeather.dart';
import '../models/weather.dart';

class WeatherProvider with ChangeNotifier {
  String apiKey = 'Paste Your API Key Here';
  LatLng? currentLocation;
  late Weather weather;
  DailyWeather currentWeather = DailyWeather();
  List<DailyWeather> hourlyWeather = [];
  List<DailyWeather> hourly24Weather = [];
  List<DailyWeather> fiveDayWeather = [];
  List<DailyWeather> sevenDayWeather = [];
  bool isLoading = false;
  bool isRequestError = false;
  bool isLocationError = false;

  Future<void> getWeatherData({bool isRefresh = false}) async {
    isLoading = true;
    isRequestError = false;
    isLocationError = false;
    if (isRefresh) notifyListeners();
    await Location().requestService().then(
      (value) async {
        if (value) {
          final locData = await Location().getLocation();
          currentLocation = LatLng(locData.latitude!, locData.longitude!);
          await getCurrentWeather(currentLocation!);
          await getDailyWeather(currentLocation!);
        } else {
          isLoading = false;
          isLocationError = true;
          notifyListeners();
        }
      },
    );
  }

  Future<void> getCurrentWeather(LatLng location) async {
    Uri url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&units=metric&appid=$apiKey',
    );
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      weather = Weather.fromJson(extractedData);
    } catch (error) {
      print(error);
      this.isRequestError = true;
      throw error;
    } finally {
      isLoading = false;
      notifyListeners();
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
      inspect(response.body);
      final dailyData = json.decode(response.body) as Map<String, dynamic>;
      currentWeather = DailyWeather.fromJson(dailyData);
      List<DailyWeather> tempHourly = [];
      List<DailyWeather> temp24Hour = [];
      List<DailyWeather> tempSevenDay = [];
      List items = dailyData['daily'];
      List itemsHourly = dailyData['hourly'];
      tempHourly = itemsHourly
          .map((item) => DailyWeather.fromHourlyJson(item))
          .toList()
          .skip(1)
          .take(3)
          .toList();
      temp24Hour = itemsHourly
          .map((item) => DailyWeather.fromHourlyJson(item))
          .toList()
          .skip(1)
          .take(24)
          .toList();
      tempSevenDay = items
          .map((item) => DailyWeather.fromDailyJson(item))
          .toList()
          .skip(1)
          .take(7)
          .toList();
      hourlyWeather = tempHourly;
      hourly24Weather = temp24Hour;
      sevenDayWeather = tempSevenDay;
    } catch (error) {
      print(error);
      this.isRequestError = true;
      throw error;
    } finally {
      isLoading = false;
      notifyListeners();
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
      this.isRequestError = true;
      throw error;
    }
  }

  Future<void> searchWeather({required String location}) async {
    isLoading = true;
    isRequestError = false;
    isLocationError = false;
    double latitude = weather.lat;
    double longitude = weather.long;
    await searchWeatherWithLocation(location);
    await getDailyWeather(LatLng(latitude, longitude));
  }
}
