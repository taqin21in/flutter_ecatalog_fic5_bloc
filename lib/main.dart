import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog_fic5/bloc/add_product/add_product_bloc.dart';
import 'package:flutter_ecatalog_fic5/bloc/register/register_bloc.dart';
import 'package:flutter_ecatalog_fic5/bloc/splashscreen/splashscreen_bloc.dart';
import 'package:flutter_ecatalog_fic5/bloc/update_productss_cubit_with_freezed/update_productss_cubit.dart';
import 'package:flutter_ecatalog_fic5/data/datasources/auth_datasource.dart';
import 'package:flutter_ecatalog_fic5/data/datasources/products_datasource.dart';
import 'package:flutter_ecatalog_fic5/presentation/login_page.dart';
import 'package:flutter_ecatalog_fic5/themes/app_theme.dart';

import 'bloc/products/products_bloc.dart';
import 'bloc/login/login_bloc.dart';
import 'bloc/update_product_bloc/update_product_bloc.dart';
import 'bloc/update_products_bloc_with_freezed/update_products_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(AuthDatasource()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(AuthDatasource()),
        ),
        BlocProvider(
          create: (context) => ProductsBloc(ProductsDataSource()),
        ),
        BlocProvider(
          create: (context) => AddProductBloc(ProductsDataSource()),
        ),
        BlocProvider(
          create: (context) => SplashscreenBloc(),
        ),
        BlocProvider(
          create: (context) => UpdateProductBloc(ProductsDataSource()),
        ),
        BlocProvider(
          create: (context) => UpdateProductsBloc(ProductsDataSource()),
        ),
        BlocProvider(
          create: (context) => UpdateProductssCubit(ProductsDataSource()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter E- catalog',
        theme: AppTheme.dark,
        home: const LoginPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
