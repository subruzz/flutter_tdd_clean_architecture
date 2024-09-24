import 'package:dartz/dartz.dart';
import 'package:flutter_tdd/core/error/failure.dart';
import 'package:flutter_tdd/domain/entities/weather.dart';
import 'package:flutter_tdd/domain/repository/weather_repository.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository weatherRepository;

  GetCurrentWeatherUseCase({required this.weatherRepository});
  Future<Either<Failure, WeatherEntity>> execute(String city) {
    return weatherRepository.getCurrentWeather(city);
  }
}
