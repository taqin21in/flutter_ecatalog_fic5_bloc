// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'products_bloc.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<ProductsResponseModel> data;
  ProductsLoaded({
    required this.data,
  });
}

class ProductsError extends ProductsState {
  final String message;
  ProductsError({
    required this.message,
  });
}
