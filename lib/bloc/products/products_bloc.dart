import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog_fic5/data/datasources/products_datasource.dart';

import '../../data/models/response/product_response_model.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsDataSource productsDataSource;
  ProductsBloc(this.productsDataSource) : super(ProductsInitial()) {
    on<GetProductsEvent>((event, emit) async {
      emit(ProductsLoading());
      final result = await productsDataSource.getAllProducts();
      result.fold(
        (error) => emit(ProductsError(message: error)),
        (result) => emit(ProductsLoaded(data: result)),
      );
    });
  }
}
