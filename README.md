# FlutterWeather
### Updated to Flutter 3.0 & New Updated Design

A simple weather App created using [Flutter](https://flutter.dev/) and [Dart](https://dart.dev/) and using API from [OpenWeatherMap](https://openweathermap.org/)</br></br>
**New Design Inspired by [Rina Damayanti](https://dribbble.com/shots/23103004-Weather-Mobile-App) on Dribbble.**</br>

<p align="center">
<img src="https://github.com/ArizArmeidi/FlutterWeather/assets/60814961/ab3f4a18-e6bb-4688-b70b-305611d7e8b5" width="20%"></img> 
<img src="https://github.com/ArizArmeidi/FlutterWeather/assets/60814961/95cba2e0-62b7-40b5-93b2-f16ee95c96a1" width="20%"></img> 
<img src="https://github.com/ArizArmeidi/FlutterWeather/assets/60814961/9638b4d9-ec4d-4401-9052-dacaac2f7ef6" width="20%"></img> 
<img src="https://github.com/ArizArmeidi/FlutterWeather/assets/60814961/5189de89-1a3d-499a-867b-d12b856653a6" width="20%"></img>
</p>

## API Docs   
> [!IMPORTANT] 
> This project uses **_version 2.5_** of the OpenWeatherMap API</br>
> **API used in this project**:</br>
> - [Current Weather API Docs](https://openweathermap.org/current#one)</br>
> - [One Call API Docs](https://openweathermap.org/api/one-call-api#data)</br>
> - [Geocoding API Docs](https://openweathermap.org/api/geocoding-api)</br>


## Features      
- Automatically acquire user current location
- Searchable location
- Hourly weather information
- 7 days weather information          


## How to Run
1. Create an account at [OpenWeatherMap](https://openweathermap.org/).
2. Then get your API key from https://home.openweathermap.org/api_keys.
   >Sometimes after getting your OpenWeatherMap API key it won't work right away </br>
   >To test if your API key is working or not copy and paste the following link to your browser</br>
   >https://api.openweathermap.org/data/2.5/weather?lat=53.4794892&lon=-2.2451148&units=metric&appid=YOUR_API_KEY</br>
   >Then replace `YOUR_API_KEY` with your own API key from OpenWeatherMap
3. Clone the repo
   ```sh
   git clone https://github.com/ArizArmeidi/FlutterWeather.git
   ```
4. Install all the packages by typing
   ```sh
   flutter pub get
   ```
5. Navigate to **lib/provider/weatherProvider.dart** and paste your API key to the apiKey variable
   ```dart
   String apiKey = 'Paste Your API Key Here';
   ```
6. Run the App

## Contact
- [Ariz Armeidi](https://github.com/ArizArmeidi/) | [Twitter](https://twitter.com/ArizArmeidi) | [Instagram](https://www.instagram.com/ariz.armeidi/)
- If you find the content of this repository useful and you have some extra money, you can donate to me through [PayPal](https://www.paypal.com/paypalme/arizarmeidi)

## License
Distributed under the MIT License. See `LICENSE` for more information.
