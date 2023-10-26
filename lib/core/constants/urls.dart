import 'package:tdd_weather_app/core/constants/api_key.dart';

class Urls {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static String currentWeatherByName(String city) => '$baseUrl/weather?q=$city&appid=$apiKey';
  static String weatherIcon(String iconCode) => 'http://openweathermap.org/img/wn/$iconCode@2x.png';
}
