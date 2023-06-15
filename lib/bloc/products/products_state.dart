part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {}

class ProductsInitial extends ProductsState {
  @override
  List<Object?> get props => [];
}

class ProductsLoading extends ProductsState {
  @override
  List<Object?> get props => [];
}

class ProductsLoaded extends ProductsState {
  final List<ProductsResponseModel> data;
  final int offset;
  final int limit;
  final bool isNext;
  ProductsLoaded({
    required this.data,
    this.offset = 0,
    this.limit = 50,
    this.isNext = false,
  });

  ProductsLoaded copyWith({
    List<ProductsResponseModel>? data,
    int? offset,
    int? limit,
    bool? isNext,
  }) {
    return ProductsLoaded(
      data: data ?? this.data,
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
      isNext: isNext ?? this.isNext,
    );
  }

  @override
  List<Object?> get props => [data, offset, limit, isNext];
}

class ProductsError extends ProductsState {
  final String message;
  ProductsError({
    required this.message,
  });

  @override
  List<Object?> get props => [];
}
