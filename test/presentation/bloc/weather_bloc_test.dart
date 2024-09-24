import 'package:dartz/dartz.dart';
import 'package:flutter_tdd/core/error/failure.dart';
import 'package:flutter_tdd/domain/entities/weather.dart';
import 'package:flutter_tdd/presentation/bloc/weather_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helpers.mocks.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;
  setUp(
    () {
      mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
      weatherBloc = WeatherBloc(mockGetCurrentWeatherUseCase);
    },
  );
  const testWeather = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'New York';
  test(
    'initial stae should be initial',
    () {
      expect(
        weatherBloc.state,
        WeatherInitial(),
      );
    },
  );
  blocTest<WeatherBloc, WeatherState>(
    'should emit weather loaidng | weather loaded when data is gotten or getting',
    build: () {
      when(mockGetCurrentWeatherUseCase.execute(testCityName))
          .thenAnswer((_) async {
        return const Right(testWeather);
      });
      return weatherBloc;
    },
    act: (bloc) {
      bloc.add(
        const OnCityChanged(cityName: testCityName),
      );
    },
    expect: () => [
      WeatherLoading(),
      const WeatherSuccess(weatherEntity: testWeather),
    ],
  );
  blocTest<WeatherBloc, WeatherState>(
    'should emit weather loaidng | weather loaded when data is gotten or getting',
    build: () {
      when(mockGetCurrentWeatherUseCase.execute(testCityName))
          .thenAnswer((_) async {
        return const Left(
          ServerFailure('server failure'),
        );
      });
      return weatherBloc;
    },
    act: (bloc) {
      bloc.add(
        const OnCityChanged(cityName: testCityName),
      );
    },
    expect: () => [
      WeatherLoading(),
      const WeatherFailure(message: 'server failure'),
    ],
  );
}
