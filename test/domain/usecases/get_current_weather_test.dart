import 'package:dartz/dartz.dart';
import 'package:flutter_tdd/domain/entities/weather.dart';
import 'package:flutter_tdd/domain/usecases/get_current_weather.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late MockWeatherRepository mockWeatherRepository;
  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase =
        GetCurrentWeatherUseCase(weatherRepository: mockWeatherRepository);
  });
  const testWeatherDetails = WeatherEntity(
      cityName: 'New York',
      main: 'Clouds',
      description: 'few clouds',
      iconCode: '02d',
      temperature: 302.28,
      pressure: 1009,
      humidity: 70);
  const cityName = 'New york';
  test(
    'Shoud get current weather details from the repository',
    () async {
      // arrange
      when(
        mockWeatherRepository.getCurrentWeather(cityName),
      ).thenAnswer(
        (_) async => const Right(testWeatherDetails),
      );
      // act
      final res = await getCurrentWeatherUseCase.execute(cityName);
      // assert
      expect(res, const Right(testWeatherDetails));
    },
  );
}
