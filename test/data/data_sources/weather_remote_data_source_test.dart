import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_weather_app/core/constants/urls.dart';
import 'package:tdd_weather_app/core/error/server_exception.dart';
import 'package:tdd_weather_app/data/data_sources/weather_remote_data_source_impl.dart';
import 'package:tdd_weather_app/data/models/weather_model.dart';

import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl = WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });

  const testCityName = 'Tokyo';

  group('Get current weather', () {
    test('Should return weather model when the response code is 200', () async {
      when(
        mockHttpClient.get(
          Uri.parse(
            Urls.currentWeatherByName(testCityName),
          ),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('helpers/dummy_data/dummy_weather_response.json'),
          200,
        ),
      );

      final result = await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

      expect(result, isA<WeatherModel>());
    });

    test('Should throw a server exception when the response code is 404 or other', () async {
      when(
        mockHttpClient.get(
          Uri.parse(
            Urls.currentWeatherByName(testCityName),
          ),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          'Not found',
          404,
        ),
      );

      expect(() async {
        await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);
      }, throwsA(isA<ServerException>()));
    });
  });
}
