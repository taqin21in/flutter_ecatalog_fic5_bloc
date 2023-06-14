import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog_fic5/bloc/add_product/add_product_bloc.dart';
import 'package:flutter_ecatalog_fic5/bloc/register/register_bloc.dart';
import 'package:flutter_ecatalog_fic5/bloc/splashscreen/splashscreen_bloc.dart';
import 'package:flutter_ecatalog_fic5/data/datasources/auth_datasource.dart';
import 'package:flutter_ecatalog_fic5/data/datasources/products_datasource.dart';
import 'package:flutter_ecatalog_fic5/presentation/login_page.dart';

import 'bloc/products/products_bloc.dart';
import 'bloc/login/login_bloc.dart';

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
      ],
      child: MaterialApp(
        title: 'Flutter E- catalog',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
