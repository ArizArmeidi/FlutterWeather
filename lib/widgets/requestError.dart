import 'package:flutter/material.dart';

class RequestError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 150),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wrong_location_outlined,
            color: Colors.black,
            size: 100,
          ),
          SizedBox(height: 10),
          Text(
            'No Search Result',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 10),
            child: Text(
              "Please make sure that you entered the correct location name",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          // RaisedButton(
          //   color: Theme.of(context).primaryColor,
          //   child: Text('Go to Home Page'),
          //   textColor: Colors.white,
          //   padding: EdgeInsets.symmetric(horizontal: 50),
          //   onPressed: () async {
          //     await Provider.of<WeatherProvider>(context, listen: false)
          //         .getWeatherData();
          //   },
          // ),
        ],
      ),
    );
  }
}
