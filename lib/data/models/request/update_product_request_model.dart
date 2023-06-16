import 'dart:convert';

class UpdateProductRequestModel {
  String title;
  int price;
  String description;
  List<String> images;

  UpdateProductRequestModel({
    required this.title,
    required this.price,
    required this.images,
    required this.description,
  });

  factory UpdateProductRequestModel.fromJson(Map<String, dynamic> json) =>
      UpdateProductRequestModel(
        title: json["title"],
        price: json["price"],
        images: List<String>.from(json["images"].map((x) => x)),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
        "images": List<dynamic>.from(images.map((x) => x)),
        "description": description,
      };

  UpdateProductRequestModel updateProductRequestModelFromJson(String str) =>
      UpdateProductRequestModel.fromJson(json.decode(str));

  String updateProductRequestModelToJson(UpdateProductRequestModel data) =>
      json.encode(data.toJson());
}
