import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog_fic5/presentation/camera_page.dart';
import 'package:flutter_ecatalog_fic5/themes/app_theme.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/add_product/add_product_bloc.dart';
import '../bloc/products/products_bloc.dart';
import '../data/models/request/product_request_model.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController? titleController;
  TextEditingController? priceController;
  TextEditingController? descriptionController;

  XFile? picture;
  void takePicture(XFile file) {
    picture = file;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    priceController = TextEditingController();
    descriptionController = TextEditingController();
  }

  Future<void> getImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(
      source: source,
      imageQuality: 50,
    );
    if (photo != null) {
      picture = photo;
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController!.dispose();
    priceController!.dispose();
    descriptionController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product Catalog"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 16,
            ),
            picture != null
                ? SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.file(File(picture!.path)))
                : Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(border: Border.all()),
                  ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: context.theme.appColors.primary),
                  onPressed: () async {
                    await availableCameras().then(
                      (value) => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) {
                          return CameraPage(
                            takePicture: takePicture,
                            cameras: value,
                          );
                        }),
                      ),
                    );
                  },
                  child: const Text('Camera'),
                ),
                const SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: context.theme.appColors.primary),
                  onPressed: () async {
                    getImage(ImageSource.gallery);
                  },
                  child: const Text('Gallery'),
                ),
              ],
            ),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(
              height: 8,
            ),
            BlocConsumer<AddProductBloc, AddProductState>(
              listener: (context, state) {
                if (state is AddProductsLoaded) {
                  const SnackBar(
                    content: Text('success added Product'),
                  );
                  titleController!.clear();
                  priceController!.clear();
                  descriptionController!.clear();
                  Navigator.pop(context);
                  context.read<ProductsBloc>().add(GetProductsEvent());
                }
                if (state is AddProductsError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('failed Added Product')),
                  );
                }
              },
              builder: (context, state) {
                if (state is AddProductsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ElevatedButton(
                    onPressed: () {
                      final requestData = ProductsRequestModel(
                        title: titleController!.text,
                        price: int.parse(priceController!.text),
                        description: descriptionController!.text,
                      );
                      context
                          .read<AddProductBloc>()
                          .add(AddedProductEvent(model: requestData));
                    },
                    child: const Text('Submit'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
