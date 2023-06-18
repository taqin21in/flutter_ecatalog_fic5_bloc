part of 'upload_image_update_cubit.dart';

@freezed
class UploadImageUpdateState with _$UploadImageUpdateState {
  const factory UploadImageUpdateState.initial() = _Initial;
  const factory UploadImageUpdateState.loading() = _Loading;
  const factory UploadImageUpdateState.loaded(
      UpdateProductRequestModel model, int productId) = _Loaded;
  const factory UploadImageUpdateState.error(String message) = _Error;
}
