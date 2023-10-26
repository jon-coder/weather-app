import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_weather_app/domain/entities/weather.dart';
import 'package:tdd_weather_app/domain/usecases/get_current_weather.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase = GetCurrentWeatherUseCase(mockWeatherRepository);
  });

  const testWeatherDetail = WeatherEntity(
    cityName: 'Tokyo',
    description: 'few clouds',
    main: 'Clouds',
    iconCode: '02d',
    temperature: 287.76,
    pressure: 1012,
    humidity: 75,
  );

  const testCityName = 'Tokyo';

  test('Should get current weather detail from the repository', () async {
    when(mockWeatherRepository.getCurrentWeather(testCityName)).thenAnswer(
      (_) async => const Right(testWeatherDetail),
    );

    final result = await getCurrentWeatherUseCase.call(testCityName);

    expect(result, const Right(testWeatherDetail));
  });
}
