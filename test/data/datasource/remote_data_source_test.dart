import 'package:flutter_tdd/core/constants/constants.dart';
import 'package:flutter_tdd/core/error/exception.dart';
import 'package:flutter_tdd/data/datasource/remote_data_source.dart';
import 'package:flutter_tdd/data/model/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/json_reader.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSouceImpl weatherRemoteDataSourceImpl;
  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl =
        WeatherRemoteDataSouceImpl(client: mockHttpClient);
  });
  const city = 'New York';
  group(
    'Get current weather',
    () {
      test(
        'Should return weather model when response code is 200',
        () async {
          // arrange
          when(mockHttpClient.get(Uri.parse(
            Urls.currentWeatherByName(city),
          ))).thenAnswer(
            (_) async => http.Response(
                readJson('helpers/dummy_data/dummy_weather_response.json'),
                200),
          );
          // act
          final res = await weatherRemoteDataSourceImpl.getcurrentWeather(city);

          // assert
          expect(
            res,
            isA<WeatherModel>(),
          );
        },
      );
      test(
        'Should throw a server exception when the response code is not 200',
        () async {
          // arrange
          when(
            mockHttpClient.get(
              Uri.parse(
                Urls.currentWeatherByName(city),
              ),
            ),
          ).thenAnswer(
            (_) async => http.Response('Not found', 404),
          );
          // act
          expect(
            () async => await weatherRemoteDataSourceImpl
                .getcurrentWeather(city), 
            throwsA(
              isA<ServerException>(),
            ),
          );
        },
      );
    },
  );
}
