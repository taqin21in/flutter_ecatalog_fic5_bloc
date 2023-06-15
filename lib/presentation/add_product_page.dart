
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    priceController = TextEditingController();
    descriptionController = TextEditingController();
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'title'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'price'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'description'),
            ),
            const SizedBox(
              height: 6,
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
                          description: descriptionController!.text);
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
