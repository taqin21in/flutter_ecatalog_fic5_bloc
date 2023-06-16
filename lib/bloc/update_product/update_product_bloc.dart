import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog_fic5/data/datasources/products_datasource.dart';
import 'package:flutter_ecatalog_fic5/data/models/request/update_product_request_model.dart';

import '../../data/models/response/update_product_response_model.dart';

part 'update_product_event.dart';
part 'update_product_state.dart';

class UpdateProductBloc extends Bloc<UpdateProductEvent, UpdateProductState> {
  final ProductsDataSource dataSource;
  UpdateProductBloc(this.dataSource) : super(UpdateProductInitial()) {
    on<DoUpdatedProductEvent>((event, emit) async {
      emit(UpdateProductLoading());
      final result =
          await dataSource.updateProduct(event.model, event.productId);
      result.fold(
        (l) => emit(UpdateProductError(message: l)),
        (r) => emit(UpdateProductLoaded(model: r)),
      );
    });
  }
}
