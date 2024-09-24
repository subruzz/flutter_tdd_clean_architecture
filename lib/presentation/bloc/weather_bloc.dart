import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tdd/domain/entities/weather.dart';
import 'package:flutter_tdd/domain/usecases/get_current_weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  WeatherBloc(this.getCurrentWeatherUseCase) : super(WeatherInitial()) {
    on<WeatherEvent>(
      (event, emit) {},
    );
    on<OnCityChanged>(
      (event, emit) async {
        emit(WeatherLoading());
        final res = await getCurrentWeatherUseCase.execute(event.cityName);
        res.fold(
          (failure) => emit(
            WeatherFailure(
              message: failure.message,
            ),
          ),
          (success) => emit(
            WeatherSuccess(weatherEntity: success),
          ),
        );
      },
    );
  }
}
