import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog_fic5/data/datasources/products_datasource.dart';

import '../../data/models/request/product_request_model.dart';
import '../../data/models/response/product_response_model.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  final ProductsDataSource dataSource;
  AddProductBloc(this.dataSource) : super(AddProductInitial()) {
    on<AddedProductEvent>((event, emit) async {
      emit(AddProductInitial());
      final result = await dataSource.createdProduct(event.model);
      result.fold(
        (error) => emit(AddProductsError(message: error)),
        (data) => emit(AddProductsLoaded(model: data)),
      );
    });
  }
}
