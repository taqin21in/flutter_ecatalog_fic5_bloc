import 'package:flutter_bloc/flutter_bloc.dart';

part 'update_product_event.dart';
part 'update_product_state.dart';

class UpdateProductBloc extends Bloc<UpdateProductEvent, UpdateProductState> {
  UpdateProductBloc() : super(UpdateProductInitial()) {
    on<UpdateProductEvent>((event, emit) {});
  }
}
