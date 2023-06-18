// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final productsRequestModel = productsRequestModelFromMap(jsonString);

import 'dart:convert';

class ProductsRequestModel {
  String? title;
  int? price;
  String? description;
  int? categoryId;
  List<String>? images;

  ProductsRequestModel({
    this.title,
    this.price,
    this.description,
    this.categoryId = 1,
    this.images = const ['https://picsum.photos/640/640?r=9959'],
  });

  factory ProductsRequestModel.fromJson(String str) =>
      ProductsRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductsRequestModel.fromMap(Map<String, dynamic> json) =>
      ProductsRequestModel(
        title: json["title"],
        price: json["price"],
        description: json["description"],
        categoryId: json["categoryId"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "price": price,
        "description": description,
        "categoryId": categoryId,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
      };

  ProductsRequestModel copyWith({
    String? title,
    int? price,
    String? description,
    int? categoryId,
    List<String>? images,
  }) {
    return ProductsRequestModel(
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      images: images ?? this.images,
    );
  }
}
