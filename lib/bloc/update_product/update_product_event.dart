// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'update_product_bloc.dart';

abstract class UpdateProductEvent {}

class UpdatedProductEvent extends UpdateProductEvent {
  final ProductsRequestModel data;
  UpdatedProductEvent({
    required this.data,
  });
}
