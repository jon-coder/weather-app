import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:tdd_weather_app/data/data_sources/weather_remote_data_source.dart';
import 'package:tdd_weather_app/domain/repositories/weather_repository.dart';
import 'package:tdd_weather_app/domain/usecases/get_current_weather.dart';

@GenerateMocks(
  [
    WeatherRepository,
    WeatherRemoteDataSource,
    GetCurrentWeatherUseCase,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
