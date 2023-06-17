part of 'products_bloc.dart';

abstract class ProductsEvent {}

class GetProductsEvent extends ProductsEvent {}

class NextProductsEvent extends ProductsEvent {}

class AddSingleProductsEvent extends ProductsEvent {
  final ProductsResponseModel data;
  AddSingleProductsEvent({
    required this.data,
  });
}

class ClearProductEvent extends ProductsEvent {}
