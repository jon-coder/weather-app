import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository weatherRepository;
  GetCurrentWeatherUseCase({
    required this.weatherRepository,
  });

  Future<Either<Failure, WeatherEntity>> call(String cityName) {
    return weatherRepository.getCurrentWeather(cityName);
  }
}
