// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'products_bloc.dart';

abstract class ProductsEvent {}

class GetProductsEvent extends ProductsEvent {}

class NextProductsEvent extends ProductsEvent {}
