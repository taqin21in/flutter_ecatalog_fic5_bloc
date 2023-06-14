import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog_fic5/bloc/login/login_bloc.dart';
import 'package:flutter_ecatalog_fic5/data/datasources/local_datasource.dart';
import 'package:flutter_ecatalog_fic5/data/models/request/login_request_model.dart';
import 'package:flutter_ecatalog_fic5/presentation/home_page.dart';
import 'package:flutter_ecatalog_fic5/presentation/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  void initState() {
    checkAuth();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  void checkAuth() async {
    // await Future.delayed(const Duration(seconds: 3));
    final auth = await LocalDataSource().getToken();
    if (auth.isNotEmpty) {
      // ignore: use_build_context_synchronously
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const HomePage();
      }));
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController!.dispose();
    passwordController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Authentication"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text('Sign Up'),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(
              height: 6,
            ),
            BlocConsumer<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ElevatedButton(
                    onPressed: () {
                      final requestModel = LoginRequestModel(
                          email: emailController!.text,
                          password: passwordController!.text);
                      context.read<LoginBloc>().add(
                            DoLoginEvent(model: requestModel),
                          );
                    },
                    child: const Text('Login'));
              },
              listener: (context, state) {
                if (state is LoginError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
                if (state is LoginLoaded) {
                  LocalDataSource().saveToken(state.model.accessToken);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Login is success with access_token '),
                      backgroundColor: Colors.grey,
                    ),
                  );
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const HomePage();
                  }));
                }
              },
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const RegisterPage();
                }));
              },
              child: const Text('Belum Punya AKun ? Register'),
            )
          ],
        ),
      ),
    );
  }
}
