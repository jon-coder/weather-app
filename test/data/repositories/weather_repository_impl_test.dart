import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_weather_app/core/error/failure.dart';
import 'package:tdd_weather_app/core/error/server_exception.dart';
import 'package:tdd_weather_app/data/models/weather_model.dart';
import 'package:tdd_weather_app/data/repositories/weather_repository_impl.dart';
import 'package:tdd_weather_app/domain/entities/weather.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(weatherRemoteDataSource: mockWeatherRemoteDataSource);
  });

  const testWeatherModel = WeatherModel(
    cityName: 'Tokyo',
    description: 'clear sky',
    main: 'Clear',
    iconCode: '01n',
    temperature: 291.21,
    pressure: 1011,
    humidity: 63,
  );

  const testWeatherEntity = WeatherEntity(
    cityName: 'Tokyo',
    description: 'clear sky',
    main: 'Clear',
    iconCode: '01n',
    temperature: 291.21,
    pressure: 1011,
    humidity: 63,
  );

  const testCityName = 'Tokyo';

  group('Get current weather', () {
    test('Should return current weather when a call to data source is successful', () async {
      when(
        mockWeatherRemoteDataSource.getCurrentWeather(testCityName),
      ).thenAnswer((_) async => testWeatherModel);

      final result = await weatherRepositoryImpl.getCurrentWeather(testCityName);

      expect(result, equals(const Right(testWeatherEntity)));
    });

    test('Should return server error when a call to data source is unsuccessful', () async {
      when(
        mockWeatherRemoteDataSource.getCurrentWeather(testCityName),
      ).thenThrow(ServerException());

      final result = await weatherRepositoryImpl.getCurrentWeather(testCityName);

      expect(result, equals(const Left(ServerError('An error has ocurred'))));
    });

    test('Should return connection failure when the device has no internet', () async {
      when(
        mockWeatherRemoteDataSource.getCurrentWeather(testCityName),
      ).thenThrow(const SocketException('Failed to connect to the network'));

      final result = await weatherRepositoryImpl.getCurrentWeather(testCityName);

      expect(result, equals(const Left(ConnectionError('Failed to connect to the network'))));
    });
  });
}
