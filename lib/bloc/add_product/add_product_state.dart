// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_product_bloc.dart';

abstract class AddProductState {}

class AddProductInitial extends AddProductState {}

class AddProductsLoading extends AddProductState {}

class AddProductsLoaded extends AddProductState  {
  final ProductsResponseModel model;
  AddProductsLoaded({
    required this.model,
  });
}

class AddProductsError extends AddProductState {
  final String message;
  AddProductsError({
    required this.message,
  });
}
