import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog_fic5/bloc/update_productss_cubit_with_freezed/update_productss_cubit.dart';
import 'package:flutter_ecatalog_fic5/data/datasources/local_datasource.dart';
import 'package:flutter_ecatalog_fic5/data/models/request/update_product_request_model.dart';
import 'package:flutter_ecatalog_fic5/presentation/add_product_page.dart';
import 'package:flutter_ecatalog_fic5/presentation/login_page.dart';
import 'package:flutter_ecatalog_fic5/themes/app_theme.dart';
import 'package:image_picker/image_picker.dart';
import '../bloc/products/products_bloc.dart';
import 'camera_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int productId;
  TextEditingController? titleController;
  TextEditingController? priceController;
  TextEditingController? descriptionController;
  String? img;

  final scrollController = ScrollController();
  XFile? picture;
  void takePicture(XFile file) {
    picture = file;
    setState(() {});
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
        title: const Text('Home'),
        elevation: 5,
        actions: [
          IconButton(
              onPressed: () async {
                context.read<ProductsBloc>().add(ClearProductEvent());
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const LoginPage();
                }));
                await LocalDataSource().removeToken();
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
                          'ID : (${state.data.reversed.toList()[index].id}) - ${state.data.reversed.toList()[index].title}  '),
                      subtitle: Text(
                          '${state.data.reversed.toList()[index].price}\$ - ${state.data.reversed.toList()[index].description}'),
                      trailing: CircleAvatar(
                        backgroundImage: NetworkImage(
                            state.data.reversed.toList()[index].images?[0] ??
                                'https://tinyurl.com/default-fic'),
                      ),
                      onTap: () {
                        titleController!.text =
                            state.data.reversed.toList()[index].title!;
                        priceController!.text = state.data.reversed
                            .toList()[index]
                            .price!
                            .toString();
                        descriptionController!.text =
                            state.data.reversed.toList()[index].description!;
                        productId = state.data.reversed.toList()[index].id!;
                        img = state.data.reversed.toList()[index].images?[0] ??
                            'https://tinyurl.com/default-fic';
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: AlertDialog(
                                title: Text(
                                    'Update Product with ID : ${state.data[index].id}'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    picture != null
                                        ? SizedBox(
                                            height: 200,
                                            width: 200,
                                            child: img != null
                                                ? Image.network(img!)
                                                : Image.file(
                                                    File(picture!.path),
                                                  ),
                                          )
                                        : Container(
                                            height: 200,
                                            width: 200,
                                            decoration: BoxDecoration(
                                                border: Border.all()),
                                          ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: context
                                                  .theme.appColors.primary),
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
                                          child: const Text('capture'),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: context
                                                  .theme.appColors.primary),
                                          onPressed: () async {
                                            getImage(ImageSource.gallery);
                                          },
                                          child: const Text('Gallery'),
                                        ),
                                      ],
                                    ),
                                    TextField(
                                      controller: titleController,
                                      decoration: const InputDecoration(
                                          labelText: 'Title'),
                                    ),
                                    TextField(
                                      controller: priceController,
                                      decoration: const InputDecoration(
                                          labelText: 'Price'),
                                    ),
                                    TextField(
                                      controller: descriptionController,
                                      decoration: const InputDecoration(
                                          labelText: 'Description'),
                                    ),
                                  ],
                                ),
                                actions: [
                                  /// start freez annotation with cubit
                                  BlocListener<UpdateProductssCubit,
                                      UpdateProductssState>(
                                    listener: (context, state) {
                                      state.maybeWhen(
                                        loaded: (model) {
                                          const SnackBar(
                                            content: Text(
                                                'Update Product is Success'),
                                          );
                                          context
                                              .read<ProductsBloc>()
                                              .add(GetProductsEvent());
                                          titleController!.clear();
                                          priceController!.clear();
                                          descriptionController!.clear();
                                          Navigator.pop(context);
                                        },
                                        orElse: () {},
                                      );
                                    },
                                    child: BlocBuilder<UpdateProductssCubit,
                                        UpdateProductssState>(
                                      builder: (context, state) {
                                        return state.maybeWhen(
                                          orElse: () {
                                            return ElevatedButton(
                                              onPressed: () {
                                                final requestData =
                                                    UpdateProductRequestModel(
                                                        // images: List.empty(),
                                                        title: titleController!
                                                            .text,
                                                        price: int.parse(
                                                            priceController!
                                                                .text),
                                                        description:
                                                            descriptionController!
                                                                .text);
                                                context
                                                    .read<
                                                        UpdateProductssCubit>()
                                                    .updateProduct(
                                                        model: requestData,
                                                        productId: productId);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: context
                                                    .theme.appColors.primary,
                                              ),
                                              child: const Center(
                                                child: Text('update'),
                                              ),
                                            );
                                          },
                                          loading: () {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),

                                  /// end freez annotation with cubit

                                  ////// start  freez annotation with bloc
                                  // BlocListener<UpdateProductsBloc,
                                  //     UpdateProductsState>(
                                  //   listener: (context, state) {
                                  //     state.maybeWhen(
                                  //       loaded: (model) {
                                  //         const SnackBar(
                                  //           content:
                                  //               Text('Update Product is Success'),
                                  //         );
                                  //         context
                                  //             .read<ProductsBloc>()
                                  //             .add(GetProductsEvent());
                                  //         titleController!.clear();
                                  //         priceController!.clear();
                                  //         descriptionController!.clear();
                                  //         Navigator.pop(context);
                                  //       },
                                  //       orElse: () {},
                                  //     );
                                  //   },
                                  //   child: BlocBuilder<UpdateProductsBloc,
                                  //       UpdateProductsState>(
                                  //     builder: (context, state) {
                                  //       return state.maybeWhen(
                                  //         orElse: () {
                                  //           return ElevatedButton(
                                  //               onPressed: () {
                                  //                 final requestData =
                                  //                     UpdateProductRequestModel(
                                  //                         // images: List.empty(),
                                  //                         title: titleController!
                                  //                             .text,
                                  //                         price: int.parse(
                                  //                             priceController!
                                  //                                 .text),
                                  //                         description:
                                  //                             descriptionController!
                                  //                                 .text);
                                  //                 context
                                  //                     .read<UpdateProductsBloc>()
                                  //                     .add(
                                  //                       UpdateProductsEvent
                                  //                           .doUpdatedProduct(
                                  //                               model:
                                  //                                   requestData,
                                  //                               productId:
                                  //                                   productId),
                                  //                     );
                                  //               },
                                  //               style: ElevatedButton.styleFrom(
                                  //                 backgroundColor: context
                                  //                     .theme.appColors.primary,
                                  //               ),
                                  //               child:
                                  //                   const Text('Update product'));
                                  //         },
                                  //         loading: () {
                                  //           return const Center(
                                  //             child: CircularProgressIndicator(),
                                  //           );
                                  //         },
                                  //       );
                                  //     },
                                  //   ),
                                  // ),

                                  /// ---- end freezed annotation with bloc

                                  ///////// start no freeze annotion with bloc
                                  // BlocConsumer<UpdateProductBloc,
                                  //     UpdateProductState>(
                                  //   listener: (context, state) {
                                  //     if (state is UpdateProductLoaded) {
                                  //       const SnackBar(
                                  //         content:
                                  //             Text('Update Product is Success'),
                                  //       );
                                  //       context
                                  //           .read<ProductsBloc>()
                                  //           .add(GetProductsEvent());
                                  //       titleController!.clear();
                                  //       priceController!.clear();
                                  //       descriptionController!.clear();
                                  //       Navigator.pop(context);
                                  //     }
                                  //     if (state is UpdateProductError) {
                                  //       ScaffoldMessenger.of(context)
                                  //           .showSnackBar(
                                  //         const SnackBar(
                                  //             content: Text(
                                  //                 'Update product is failed')),
                                  //       );
                                  //     }
                                  //   },
                                  //   builder: (context, state) {
                                  //     if (state is UpdateProductLoading) {
                                  //       return const Center(
                                  //         child: CircularProgressIndicator(),
                                  //       );
                                  //     }
                                  //     return ElevatedButton(
                                  //       onPressed: () {
                                  //         final requestData =
                                  //             UpdateProductRequestModel(
                                  //                 // images: List.empty(),
                                  //                 title: titleController!.text,
                                  //                 price: int.parse(
                                  //                     priceController!.text),
                                  //                 description:
                                  //                     descriptionController!
                                  //                         .text);
                                  //         debugPrint(
                                  //           'request data presentation : ${requestData.toJson()}',
                                  //         );
                                  //         debugPrint('productId : $productId');
                                  //         context.read<UpdateProductBloc>().add(
                                  //             DoUpdatedProductEvent(
                                  //                 model: requestData,
                                  //                 productId: productId!));
                                  //       },
                                  //       child: const Text('Update Product'),
                                  //     );
                                  //   },
                                  // ),
                                  /////////// end freezed annotation with bloc
                                ],
                              ),
                            );
                          },
                        );
                      },
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
          // BlocConsumer<AddProductBloc, AddProductState>(
          //   listener: (context, state) {
          //     if (state is AddProductsLoaded) {
          //       const SnackBar(
          //         content: Text('Add Product Success'),
          //       );
          //       // context.read<ProductsBloc>().add(GetProductsEvent());
          //       context
          //           .read<ProductsBloc>()
          //           .add(AddSingleProductsEvent(data: state.model));
          //       titleController!.clear();
          //       priceController!.clear();
          //       descriptionController!.clear();
          //       Navigator.pop(context);
          //     }
          //     if (state is AddProductsError) {
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         const SnackBar(content: Text('Add product failed')),
          //       );
          //     }
          //   },
          //   builder: (context, state) {
          //     if (state is AddProductsLoading) {
          //       return const Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //     return ElevatedButton(
          //         onPressed: () {
          //           final requestData = ProductsRequestModel(
          //               title: titleController!.text,
          //               price: int.parse(priceController!.text),
          //               description: descriptionController!.text);
          //           context
          //               .read<AddProductBloc>()
          //               .add(AddedProductEvent(model: requestData));
          //         },
          //         child: const Text('Add'));
          //   },
          // ),
          //   ],
          // );
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
