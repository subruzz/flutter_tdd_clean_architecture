import 'package:dartz/dartz.dart';
import 'package:flutter_tdd/core/error/failure.dart';
import 'package:flutter_tdd/domain/entities/weather.dart';

abstract interface class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String city);
}
