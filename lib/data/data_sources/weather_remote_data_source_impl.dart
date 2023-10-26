import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/constants/urls.dart';
import '../../core/error/server_exception.dart';
import '../models/weather_model.dart';
import 'weather_remote_data_source.dart';

class WeatherRemoteDataSourceImpl extends WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final response = await client.get(Uri.parse(Urls.currentWeatherByName(cityName)));
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
