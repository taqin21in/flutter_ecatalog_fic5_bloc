import 'dart:convert';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecatalog_fic5/data/models/request/product_request_model.dart';
import 'package:flutter_ecatalog_fic5/data/models/request/update_product_request_model.dart';
import 'package:flutter_ecatalog_fic5/data/models/response/product_response_model.dart';
import 'package:flutter_ecatalog_fic5/data/models/response/update_product_response_model.dart';
import 'package:http/http.dart' as http;

import '../models/response/upload_image_response_model.dart';

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

  Future<Either<String, List<ProductsResponseModel>>> getPaginationProduct(
      {required int offset, required int limit}) async {
    final response = await http.get(Uri.parse(
        'https://api.escuelajs.co/api/v1/products/?offset=$offset&limit=$limit'));
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

  Future<Either<String, UpdateProductResponseModel>> updateProduct(
      UpdateProductRequestModel model, productId) async {
    try {
      debugPrint(
        'request data with data source jsonEncode before sending ${jsonEncode(model.toJson())}',
      );
      final response = await http.put(
        Uri.parse('https://api.escuelajs.co/api/v1/products/$productId'),
        body: {
          "title": model.title,
          "price": model.price.toString(),
          "description": model.description,
          "images": model.images
        },
      );
      debugPrint(
        'result resposne from sever : ${jsonDecode(response.body).toString()}',
      );
      if (response.statusCode == 200) {
        return Right(
            UpdateProductResponseModel.fromJson(jsonDecode(response.body)));
      } else {
        return const Left('update Product is Error');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return const Left('update Product is Error');
  }

  Future<Either<String, UploadImageResponseModel>> uploadImage(
    XFile image,
  ) async {
    const baseUrl = "https://api.escuelajs.co/api/v1/files/upload";
    final request = http.MultipartRequest('POST', Uri.parse(baseUrl));

    final bytes = await image.readAsBytes();

    final multiPartFile = http.MultipartFile.fromBytes(
      'file',
      bytes,
      filename: image.path,
    );

    request.files.add(multiPartFile);

    http.StreamedResponse response = await request.send();

    final Uint8List responseList = await response.stream.toBytes();
    final String responseData = String.fromCharCodes(responseList);

    if (response.statusCode == 201) {
      return Right(UploadImageResponseModel.fromJson(jsonDecode(responseData)));
    } else {
      return const Left("Failed Upload Image");
    }
  }
}
