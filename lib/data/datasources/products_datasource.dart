import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_ecatalog_fic5/data/models/request/product_request_model.dart';
import 'package:flutter_ecatalog_fic5/data/models/response/product_response_model.dart';
import 'package:http/http.dart' as http;

class ProductsDataSource {
  Future<Either<String, List<ProductsResponseModel>>> getAllProducts() async {
    final response =
        await http.get(Uri.parse('https://api.escuelajs.co/api/v1/products/'));
    if (response.statusCode == 200) {
      return Right(
        List<ProductsResponseModel>.from(
          jsonDecode(response.body).map(
            (x) => ProductsResponseModel.fromMap(x),
          ),
        ),
      );
    } else {
      return const Left('Get Product is Error');
    }
  }

  Future<Either<String, ProductsResponseModel>> createdProduct(
      ProductsRequestModel model) async {
    final response = await http.post(
        Uri.parse('https://api.escuelajs.co/api/v1/products/'),
        body: model.toJson(),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 201) {
      return Right(ProductsResponseModel.fromJson(response.body));
    } else {
      return const Left('add Product is Error');
    }
  }
}
