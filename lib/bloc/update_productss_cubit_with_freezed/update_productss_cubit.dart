import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/datasources/products_datasource.dart';
import '../../data/models/request/update_product_request_model.dart';
import '../../data/models/response/update_product_response_model.dart';

part 'update_productss_state.dart';
part 'update_productss_cubit.freezed.dart';

class UpdateProductssCubit extends Cubit<UpdateProductssState> {
  final ProductsDataSource dataSource;
  UpdateProductssCubit(this.dataSource)
      : super(const UpdateProductssState.initial());

  void updateProduct(
      {required UpdateProductRequestModel model,
      required int productId}) async {
    emit(const UpdateProductssState.loading());
    final result = await dataSource.updateProduct(model, productId);
    result.fold(
      (l) => emit(UpdateProductssState.error(l)),
      (r) => emit(UpdateProductssState.loaded(r)),
    );
  }
}
