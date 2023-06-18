import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog_fic5/data/datasources/products_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/request/product_request_model.dart';
import '../../data/models/response/product_response_model.dart';

part 'upload_gallery_camera_state.dart';
part 'upload_gallery_camera_cubit.freezed.dart';

class UploadGalleryCameraCubit extends Cubit<UploadGalleryCameraState> {
  final ProductsDataSource dataSource;
  UploadGalleryCameraCubit(this.dataSource)
      : super(const UploadGalleryCameraState.initial());

  // ignore: non_constant_identifier_names
  void addProducts(
      {required ProductsRequestModel model, required XFile image}) async {
    emit(const UploadGalleryCameraState.loading());
    final uploadResult = await dataSource.uploadImage(image);
    uploadResult.fold((error) => emit(_$_Error(error)), (uploadImage) async {
      final result = await dataSource.createdProduct(
        model.copyWith(
          images: [uploadImage.location],
        ),
      );
      result.fold(
        (error) => emit(_$_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}
