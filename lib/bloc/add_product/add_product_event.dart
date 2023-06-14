// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_product_bloc.dart';

abstract class AddProductEvent {}

class AddedProductEvent extends AddProductEvent {
  final ProductsRequestModel model;
  AddedProductEvent({
    required this.model,
  });
}
