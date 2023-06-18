import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_image_response_model.freezed.dart';
part 'upload_image_response_model.g.dart';

@freezed
class UploadImageResponseModel with _$UploadImageResponseModel {
  const factory UploadImageResponseModel({
    required String originalname,
    required String filename,
    required String location,
  }) = _UploadImageResponseModel;

  factory UploadImageResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UploadImageResponseModelFromJson(json);
}
