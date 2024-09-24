import 'package:flutter_tdd/data/datasource/remote_data_source.dart';
import 'package:flutter_tdd/domain/repository/weather_repository.dart';
import 'package:flutter_tdd/domain/usecases/get_current_weather.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks(
  [WeatherRepository, WeatherRemoteDataSouce, GetCurrentWeatherUseCase],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
