part of 'update_productss_cubit.dart';

@freezed
class UpdateProductssState with _$UpdateProductssState {
  const factory UpdateProductssState.initial() = _Initial;
  const factory UpdateProductssState.loading() = _Loading;
  const factory UpdateProductssState.loaded(UpdateProductResponseModel model) =
      _Loaded;
  const factory UpdateProductssState.error(String message) = _Error;
}
