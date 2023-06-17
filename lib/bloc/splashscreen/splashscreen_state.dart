part of 'splashscreen_bloc.dart';

abstract class SplashscreenState {}

class SplashscreenInitial extends SplashscreenState {}

class SplashscreenLoaded extends SplashscreenState {}

class SplashscreenError extends SplashscreenState {
  final String message;
  SplashscreenError({
    required this.message,
  });
}
