part of 'upload_gallery_camera_cubit.dart';

@freezed
class UploadGalleryCameraState with _$UploadGalleryCameraState {
  const factory UploadGalleryCameraState.initial() = _Initial;
  const factory UploadGalleryCameraState.loading() = _Loading;
  const factory UploadGalleryCameraState.loaded(ProductsResponseModel model) =
      _Loaded;
  const factory UploadGalleryCameraState.error(String message) = _Error;
}
