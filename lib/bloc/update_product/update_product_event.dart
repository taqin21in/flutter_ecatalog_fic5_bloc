part of 'update_product_bloc.dart';

abstract class UpdateProductEvent {}

class DoUpdatedProductEvent extends UpdateProductEvent {
  final UpdateProductRequestModel model;
  final int productId;
  DoUpdatedProductEvent({required this.model, required this.productId});
}
