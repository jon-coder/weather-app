import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../core/error/server_exception.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../data_sources/weather_remote_data_source.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;

  WeatherRepositoryImpl({
    required this.weatherRemoteDataSource,
  });
  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName) async {
    try {
      final result = await weatherRemoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerError('An error has ocurred'));
    } on SocketException {
      return const Left(ConnectionError('Failed to connect to the network'));
    }
  }
}
