import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetCurrentWeather {
  final WeatherRepository weatherRepository;
  GetCurrentWeather(this.weatherRepository);

  Future<Either<Failure, WeatherEntity>> call(String cityName) {
    return weatherRepository.getCurrentWeather(cityName);
  }
}
