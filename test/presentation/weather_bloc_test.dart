import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_weather_app/core/error/failure.dart';
import 'package:tdd_weather_app/domain/entities/weather.dart';
import 'package:tdd_weather_app/presentation/weather_bloc/weather_bloc.dart';
import 'package:tdd_weather_app/presentation/weather_bloc/weather_event.dart';
import 'package:tdd_weather_app/presentation/weather_bloc/weather_state.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc = WeatherBloc(getCurrentWeatherUseCase: mockGetCurrentWeatherUseCase);
  });

  const testWeatherEntity = WeatherEntity(
    cityName: 'Tokyo',
    description: 'clear sky',
    main: 'Clear',
    iconCode: '01n',
    temperature: 291.21,
    pressure: 1011,
    humidity: 63,
  );

  const testCityName = 'Tokio';

  test('Initial state should be empty', () {
    expect(weatherBloc.state, WeatherEmpty());
  });

  blocTest<WeatherBloc, WeatherState>(
    'Should emit [WeatherLoading, WeatherLoadFailure] when get data is unsuccessful',
    build: () {
      when(
        mockGetCurrentWeatherUseCase.call(testCityName),
      ).thenAnswer((_) async => const Left(ServerError('Server Failure')));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(
      const OnCityChanged(cityName: testCityName),
    ),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      const WeatherFailure(message: 'Server Failure'),
    ],
  );

  blocTest<WeatherBloc, WeatherState>(
    'Should emit [WeatherLoading, WeatherLoaded] when data is gotten successly',
    build: () {
      when(
        mockGetCurrentWeatherUseCase.call(testCityName),
      ).thenAnswer((_) async => const Right(testWeatherEntity));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(
      const OnCityChanged(cityName: testCityName),
    ),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      const WeatherLoaded(result: testWeatherEntity),
    ],
  );
}
