import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/datasources/products_datasource.dart';
import '../../data/models/request/update_product_request_model.dart';
import '../../data/models/response/update_product_response_model.dart';

part 'update_products_event.dart';
part 'update_products_state.dart';
part 'update_products_bloc.freezed.dart';

class UpdateProductsBloc
    extends Bloc<UpdateProductsEvent, UpdateProductsState> {
  final ProductsDataSource dataSource;
  UpdateProductsBloc(this.dataSource) : super(const _Initial()) {
    on<_DoUpdateProduct>((event, emit) async {
      emit(const _Loading());
      final result =
          await dataSource.updateProduct(event.model, event.productId);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loadeded(r)),
      );
    });
  }
}
