import 'dart:convert';

import 'package:flutter_tdd/data/model/weather_model.dart';
import 'package:flutter_tdd/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/json_reader.dart';

void main() {
  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clear',
    description: 'clear sky',
    iconCode: '01n',
    temperature: 292.87,
    pressure: 1012,
    humidity: 70,
  );
  test(
    'Should be a subclass of weather entity',
    () async {
      expect(testWeatherModel, isA<WeatherEntity>());
    },
  );
  test(
    'Should return a valid model from json',
    () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(
        readJson('helpers/dummy_data/dummy_weather_response.json'),
      );
      // act

      final res = WeatherModel.fromJson(jsonMap);
      // assert
      expect(
        res,
        equals(testWeatherModel),
      );
  
    },
  );
  test(
    'Should return a json map containing proper data',
    () async {
      // arrange
      // act
      final json = testWeatherModel.toJson();

      // assert
      final expectedJsonMap = {
        'weather': [
          {
            'main': 'Clear',
            'description': 'clear sky',
            'icon': '01n',
          }
        ],
        'main': {
          'temp': 292.87,
          'pressure': 1012,
          'humidity': 70,
        },
        'name': 'New York',
      };

      expect(
        json,
        equals(expectedJsonMap),
      );
    },
  );
}
