import 'package:flutter_bloc/flutter_bloc.dart';

part 'splashscreen_event.dart';
part 'splashscreen_state.dart';

class SplashscreenBloc extends Bloc<SplashscreenEvent, SplashscreenState> {
  SplashscreenBloc() : super(SplashscreenInitial()) {
    on<SplashscreenEvent>((event, emit) {
      emit(SplashscreenInitial());
    });
  }
}
