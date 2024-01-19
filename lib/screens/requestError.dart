import 'package:flutter/material.dart';
import 'package:flutter_weather/theme/colors.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:provider/provider.dart';

import '../provider/weatherProvider.dart';
import '../theme/textStyle.dart';

class RequestErrorDisplay extends StatelessWidget {
  const RequestErrorDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width,
              minWidth: 100,
              maxHeight: MediaQuery.sizeOf(context).height / 3,
            ),
            child: Image.asset('assets/images/requestError.png'),
          ),
          Center(
            child: Text(
              'Request Error',
              style: boldText.copyWith(color: primaryBlue),
            ),
          ),
          const SizedBox(height: 4.0),
          Center(
            child: Text(
              'Request error, please check your internet connection',
              style: mediumText.copyWith(color: Colors.grey.shade700),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16.0),
          Consumer<WeatherProvider>(builder: (context, weatherProv, _) {
            return SizedBox(
              width: MediaQuery.sizeOf(context).width / 2,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  textStyle: mediumText,
                  padding: const EdgeInsets.all(12.0),
                  shape: StadiumBorder(),
                ),
                child: Text('Return Home'),
                onPressed: weatherProv.isLoading
                    ? null
                    : () async {
                        await weatherProv.getWeatherData(
                          context,
                          notify: true,
                        );
                      },
              ),
            );
          }),
        ],
      ),
    );
  }
}

class SearchErrorDisplay extends StatelessWidget {
  const SearchErrorDisplay({
    Key? key,
    required this.fsc,
  }) : super(key: key);

  final FloatingSearchBarController fsc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width,
              minWidth: 100,
              maxHeight: MediaQuery.sizeOf(context).height / 3,
            ),
            child: Image.asset('assets/images/searchError.png'),
          ),
          Center(
            child: Text(
              'Search Error',
              style: boldText.copyWith(color: primaryBlue),
            ),
          ),
          const SizedBox(height: 4.0),
          Center(
            child: Text(
              'Unable to find "${fsc.query}", check for typo or check your internet connection',
              style: mediumText.copyWith(color: Colors.grey.shade700),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16.0),
          Consumer<WeatherProvider>(builder: (context, weatherProv, _) {
            return SizedBox(
              width: MediaQuery.sizeOf(context).width / 2,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  textStyle: mediumText,
                  padding: const EdgeInsets.all(12.0),
                  shape: StadiumBorder(),
                ),
                child: Text('Return Home'),
                onPressed: weatherProv.isLoading
                    ? null
                    : () async {
                        await weatherProv.getWeatherData(
                          context,
                          notify: true,
                        );
                      },
              ),
            );
          }),
        ],
      ),
    );
  }
}
