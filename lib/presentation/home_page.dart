import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog_fic5/data/datasources/local_datasource.dart';
import 'package:flutter_ecatalog_fic5/presentation/add_product_page.dart';
import 'package:flutter_ecatalog_fic5/presentation/login_page.dart';
import '../bloc/products/products_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController? titleController;
  TextEditingController? priceController;
  TextEditingController? descriptionController;
  final scrollController = ScrollController();

  @override
  void initState() {
    titleController = TextEditingController();
    priceController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
    context.read<ProductsBloc>().add(GetProductsEvent());

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        context.read<ProductsBloc>().add(NextProductsEvent());
      }
    });
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
        title: const Text('Dashboard'),
        elevation: 5,
        actions: [
          IconButton(
              onPressed: () async {
                await LocalDataSource().removeToken();
                // ignore: use_build_context_synchronously
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const LoginPage();
                }));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoaded) {
            debugPrint('total data : ${state.data.length}');
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                controller: scrollController,
                // reverse: true,
                itemBuilder: (context, index) {
                  if (state.isNext && index == state.data.length) {
                    return const Card(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return Card(
                    child: ListTile(
                      title: Text(
                        state.data[index].title ?? '-',
                      ),
                      subtitle: Text('${state.data[index].price}\$'),
                    ),
                  );
                },
                itemCount:
                    state.isNext ? state.data.length + 1 : state.data.length,
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddProductPage();
          }));
          // showDialog(
          //   context: context,
          //   builder: (context) {
          //     return AlertDialog(
          //       title: const Text('Add Product'),
          //       content: Column(
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           TextField(
          //             controller: titleController,
          //             decoration: const InputDecoration(labelText: 'title'),
          //           ),
          //           TextField(
          //             controller: priceController,
          //             decoration: const InputDecoration(labelText: 'price'),
          //           ),
          //           TextField(
          //             controller: descriptionController,
          //             decoration:
          //                 const InputDecoration(labelText: 'description'),
          //           ),
          //         ],
          //       ),
          //       actions: [
          //         ElevatedButton(
          //             onPressed: () {
          //               Navigator.pop(context);
          //             },
          //             child: const Text('Cancel')),
          //         const SizedBox(
          //           width: 8,
          //         ),
          //         BlocConsumer<AddProductBloc, AddProductState>(
          //           listener: (context, state) {
          //             if (state is AddProductsLoaded) {
          //               const SnackBar(
          //                 content: Text('Add Product Success'),
          //               );
          //               context.read<ProductsBloc>().add(GetProductsEvent());
          //               titleController!.clear();
          //               priceController!.clear();
          //               descriptionController!.clear();
          //               Navigator.pop(context);
          //             }
          //             if (state is AddProductsError) {
          //               ScaffoldMessenger.of(context).showSnackBar(
          //                 const SnackBar(content: Text('Add product failed')),
          //               );
          //             }
          //           },
          //           builder: (context, state) {
          //             if (state is AddProductsLoading) {
          //               return const Center(
          //                 child: CircularProgressIndicator(),
          //               );
          //             }
          //             return ElevatedButton(
          //                 onPressed: () {
          //                   final requestData = ProductsRequestModel(
          //                       title: titleController!.text,
          //                       price: int.parse(priceController!.text),
          //                       description: descriptionController!.text);
          //                   context
          //                       .read<AddProductBloc>()
          //                       .add(AddedProductEvent(model: requestData));
          //                 },
          //                 child: const Text('Add'));
          //           },
          //         ),
          //       ],
          //     );
          //   },
          // );
        },
        child: const Icon(
          Icons.add,
          size: 24.0,
        ),
      ),
    );
  }
}
