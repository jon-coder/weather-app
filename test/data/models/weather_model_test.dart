import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_weather_app/data/models/weather_model.dart';

import '../../helpers/json_reader.dart';

void main() {
  const testWeatherModel = WeatherModel(
    cityName: 'Tokyo',
    description: 'clear sky',
    main: 'Clear',
    iconCode: '01n',
    temperature: 291.21,
    pressure: 1011,
    humidity: 63,
  );
  test('Should be a subclass of weather entity', (() {
    expect(testWeatherModel, isA<WeatherModel>());
  }));

  test('Should return a valid model from json', () {
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('helpers/dummy_data/dummy_weather_response.json'),
    );

    final result = WeatherModel.fromJson(jsonMap);

    expect(result, equals(testWeatherModel));
  });

  test('Should return a jason map containing proper data', () {
    final result = testWeatherModel.toJson();

    final expectedJsonMap = {
      'weather': [
        {
          'main': 'Clear',
          'description': 'clear sky',
          'icon': '01n',
        },
      ],
      'main': {
        'temp': 291.21,
        'pressure': 1011,
        'humidity': 63,
      },
      'name': 'Tokyo',
    };

    expect(result, equals(expectedJsonMap));
  });
}
