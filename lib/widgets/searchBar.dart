import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/weatherProvider.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _textController = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 25,
        horizontal: MediaQuery.of(context).size.width * .05,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 15,
            offset: Offset(8, 6),
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        style: TextStyle(color: Colors.black),
        maxLines: 1,
        controller: _textController,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey),
          errorText: _validate ? null : null,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          icon: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
          contentPadding: EdgeInsets.only(
            left: 0,
            bottom: 11,
            top: 11,
            right: 15,
          ),
          hintText: "Search Location",
        ),
        onSubmitted: (value) {
          setState(() {
            _textController.text.isEmpty
                ? _validate = true
                : Provider.of<WeatherProvider>(context, listen: false)
                    .searchWeatherData(location: value);
          });
        },
      ),
    );
  }
}
