import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/usecases/get_current_weather.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;
  WeatherBloc({
    required getCurrentWeatherUseCase,
  })  : _getCurrentWeatherUseCase = getCurrentWeatherUseCase,
        super(WeatherEmpty()) {
    on<OnCityChanged>(
      (event, emit) async {
        emit(WeatherLoading());
        final result = await _getCurrentWeatherUseCase.call(event.cityName);
        result.fold(
          (failure) => emit(
            WeatherFailure(message: failure.message),
          ),
          (data) => emit(
            WeatherLoaded(result: data),
          ),
        );
      },
      transformer: debounce(
        const Duration(milliseconds: 500),
      ),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
