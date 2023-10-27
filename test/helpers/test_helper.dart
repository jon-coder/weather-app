import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:tdd_weather_app/data/data_sources/weather_remote_data_source.dart';
import 'package:tdd_weather_app/domain/repositories/weather_repository.dart';

@GenerateMocks(
  [
    WeatherRepository,
    WeatherRemoteDataSource,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
