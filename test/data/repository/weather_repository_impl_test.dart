import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_tdd/core/error/exception.dart';
import 'package:flutter_tdd/core/error/failure.dart';
import 'package:flutter_tdd/data/model/weather_model.dart';
import 'package:flutter_tdd/data/repository/weather_repository_impl.dart';
import 'package:flutter_tdd/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late MockWeatherRemoteDataSouce mockWeatherRemoteDataSouce;
  late WeatherRepositoryImpl weatherRepositoryImpl;
  setUp(
    () {
      mockWeatherRemoteDataSouce = MockWeatherRemoteDataSouce();
      weatherRepositoryImpl = WeatherRepositoryImpl(
          weatherRemoteDataSouce: mockWeatherRemoteDataSouce);
    },
  );
  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testWeatherEntity = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'New York';

  group(
    'Get current weather',
    () {
      test(
        'Should return current weather when a call to datasource is successfull',
        () async {
          // arrange
          when(mockWeatherRemoteDataSouce.getcurrentWeather(testCityName))
              .thenAnswer((_) async => testWeatherModel);
          final res =
              await weatherRepositoryImpl.getCurrentWeather(testCityName);
          expect(
            res,
            equals(
              const Right(testWeatherEntity),
            ),
          );
        },
      );
      test(
        'Should return serverfailure if datasource call failed',
        () async {
          // arrange
          when(mockWeatherRemoteDataSouce.getcurrentWeather(testCityName))
              .thenThrow(
            ServerException(),
          );
          final res =
              await weatherRepositoryImpl.getCurrentWeather(testCityName);
          expect(
            res,
            equals(
              const Left(
                ServerFailure('An error has occurred'),
              ),
            ),
          );
        },
      );
      test(
        'Should return connection failure if there is no internet',
        () async {
          // arrange
          when(mockWeatherRemoteDataSouce.getcurrentWeather(testCityName))
              .thenThrow(
            const SocketException('Failed to connect to the network'),
          );
          final res =
              await weatherRepositoryImpl.getCurrentWeather(testCityName);
          expect(
            res,
            equals(
              const Left(
                ConnectionFailure('Failed to connect to the network'),
              ),
            ),
          );
        },
      );
    },
  );
}
