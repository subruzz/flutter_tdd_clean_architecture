import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_tdd/core/error/exception.dart';
import 'package:flutter_tdd/core/error/failure.dart';
import 'package:flutter_tdd/data/datasource/remote_data_source.dart';
import 'package:flutter_tdd/domain/entities/weather.dart';
import 'package:flutter_tdd/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSouce weatherRemoteDataSouce;

  WeatherRepositoryImpl({required this.weatherRemoteDataSouce});
  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String city) async {
    try {
      final result = await weatherRemoteDataSouce.getcurrentWeather(city);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(
        ServerFailure('An error has occurred'),
      );
    } on SocketException {
      return const Left(
        ConnectionFailure('Failed to connect to the network'),
      );
    }
  }
}
