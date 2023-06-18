import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/datasources/products_datasource.dart';
import '../../data/models/request/update_product_request_model.dart';

part 'upload_image_update_state.dart';
part 'upload_image_update_cubit.freezed.dart';

class UploadImageUpdateCubit extends Cubit<UploadImageUpdateState> {
  final ProductsDataSource dataSource;
  UploadImageUpdateCubit(this.dataSource)
      : super(const UploadImageUpdateState.initial());
  void updateProducts(
      {required UpdateProductRequestModel model,
      required int productId,
      required XFile image}) async {
    emit(const _Loading());
    final uploadResult = await dataSource.uploadImage(image);
    uploadResult.fold((error) => emit(_Error(error)), (uploadImage) async {
      final result = await dataSource.updateProduct(
          model.copyWith(images: [uploadImage.location]), productId);
      result.fold(
        (error) => emit(_Error(error)),
        (data) {
          emit(
            _Loaded(model, productId),
          );
        },
      );
    });
  }
}
