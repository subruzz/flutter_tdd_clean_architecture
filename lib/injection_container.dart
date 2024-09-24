import 'package:flutter_tdd/data/datasource/remote_data_source.dart';
import 'package:flutter_tdd/data/repository/weather_repository_impl.dart';
import 'package:flutter_tdd/domain/repository/weather_repository.dart';
import 'package:get_it/get_it.dart';
import 'domain/usecases/get_current_weather.dart';
import 'presentation/bloc/weather_bloc.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void setupLocator() {
  // bloc
  locator.registerFactory(() => WeatherBloc(locator()));

  // usecase
  locator.registerLazySingleton(
      () => GetCurrentWeatherUseCase(weatherRepository: locator()));

  // repository
  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(weatherRemoteDataSouce: locator()),
  );

  // data source
  locator.registerLazySingleton<WeatherRemoteDataSouce>(
    () => WeatherRemoteDataSouceImpl(
      client: locator(),
    ),
  );

  // external
  locator.registerLazySingleton(() => http.Client());
}
