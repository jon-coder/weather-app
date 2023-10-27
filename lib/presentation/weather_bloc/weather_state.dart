import 'package:equatable/equatable.dart';

import 'package:tdd_weather_app/domain/entities/weather.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherEntity result;
  const WeatherLoaded({
    required this.result,
  });

  @override
  List<Object?> get props => [
        result,
      ];
}

class WeatherFailure extends WeatherState {
  final String message;
  const WeatherFailure({
    required this.message,
  });

  @override
  List<Object?> get props => [
        message,
      ];
}
