part of 'update_products_bloc.dart';

@freezed
class UpdateProductsEvent with _$UpdateProductsEvent {
  const factory UpdateProductsEvent.started() = _Started;
  const factory UpdateProductsEvent.doUpdatedProduct(
      {required UpdateProductRequestModel model,
      required int productId}) = _DoUpdateProduct;
}
