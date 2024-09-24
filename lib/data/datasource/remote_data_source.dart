import 'dart:convert';
import 'dart:developer';

import 'package:flutter_tdd/core/error/exception.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tdd/data/model/weather_model.dart';

import '../../core/constants/constants.dart';

abstract class WeatherRemoteDataSouce {
  Future<WeatherModel> getcurrentWeather(String city);
}

class WeatherRemoteDataSouceImpl implements WeatherRemoteDataSouce {
  final http.Client client;

  WeatherRemoteDataSouceImpl({required this.client});
  @override
  Future<WeatherModel> getcurrentWeather(String city) async {
    try {
      final response =
          await client.get(Uri.parse(Urls.currentWeatherByName(city)));

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(json.decode(response.body));
      } else {
        throw ServerException();
      }
    } catch (e) {
      log('error is ${e.toString()}');
      rethrow;
    }
  }
}
