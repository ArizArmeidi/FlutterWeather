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
    return Consumer<WeatherProvider>(builder: (context, weatherProv, _) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
          child: TextField(
            enabled: !weatherProv.isLoading,
            style: TextStyle(color: Colors.black),
            maxLines: 1,
            controller: _textController,
            decoration: InputDecoration(
              hintText: 'Search Location',
              suffixIcon: _textController.text.isEmpty
                  ? null
                  : InkWell(
                      radius: 4.0,
                      onTap: () {
                        setState(() {
                          _textController.clear();
                        });
                      },
                      child: Icon(Icons.close, color: Colors.blue),
                    ),
              hintStyle: TextStyle(color: Colors.grey),
              errorText: _validate ? null : null,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              icon: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.search,
                  color: Colors.blue,
                ),
              ),
              contentPadding: EdgeInsets.only(
                top: _textController.text.isEmpty ? 12.0 : 14.0,
                bottom: _textController.text.isEmpty ? 12.0 : 0.0,
              ),
            ),
            onChanged: (value) => setState(() {}),
            onSubmitted: (query) {
              setState(() {
                _textController.text.isEmpty
                    ? _validate = true
                    : weatherProv.searchWeather(query);
              });
              FocusScope.of(context).unfocus();
            },
          ),
        ),
      );
    });
  }
}
