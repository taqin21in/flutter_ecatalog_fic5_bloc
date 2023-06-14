import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/auth_datasource.dart';
import '../../data/models/request/login_request_model.dart';
import '../../data/models/response/login_response_model.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthDatasource datasource;
  LoginBloc(this.datasource) : super(LoginInitial()) {
    on<DoLoginEvent>((event, emit) async {
      emit(LoginLoading());
      final result = await datasource.login(event.model);
      result.fold(
        (error) => emit(LoginError(message: error)),
        (data) => emit(LoginLoaded(model: data)),
      );
    });
  }
}
