part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

final class WeatherInitial extends WeatherState {}

final class WeatherEmpty extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherSuccess extends WeatherState {
  final WeatherEntity weatherEntity;

  const WeatherSuccess({required this.weatherEntity});
}

final class WeatherFailure extends WeatherState {
  final String message;

  const WeatherFailure({required this.message});
}
