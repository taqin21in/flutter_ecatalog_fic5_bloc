// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'update_product_bloc.dart';

abstract class UpdateProductState {}

class UpdateProductInitial extends UpdateProductState {}

class UpdateProductLoading extends UpdateProductState {}

class UpdateProductLoaded extends UpdateProductState {
  final UpdateProductResponseModel model;
  UpdateProductLoaded({
    required this.model,
  });
}

class UpdateProductError extends UpdateProductState {
  final String message;
  UpdateProductError({
    required this.message,
  });
}
