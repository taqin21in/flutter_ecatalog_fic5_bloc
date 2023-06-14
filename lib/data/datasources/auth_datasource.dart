import 'package:dartz/dartz.dart';
import 'package:flutter_ecatalog_fic5/data/models/request/login_request_model.dart';
import 'package:flutter_ecatalog_fic5/data/models/response/login_response_model.dart';
import 'package:http/http.dart' as http;

import '../models/request/register_request_model.dart';
import '../models/response/register_response_model.dart';

class AuthDatasource {
  Future<Either<String, RegisterResponseModel>> register(
      RegisterRequestModel model) async {
    final response = await http.post(
      Uri.parse('https://api.escuelajs.co/api/v1/users/'),
      body: model.toJson(),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      return Right(RegisterResponseModel.fromJson(response.body));
    } else {
      return const Left('Register gagal');
    }
  }

  Future<Either<String, LoginResponseModel>> login(
      LoginRequestModel model) async {
    final response = await http.post(
      Uri.parse('https://api.escuelajs.co/api/v1/auth/login'),
      body: model.toJson(),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 201) {
      return Right(LoginResponseModel.fromJson(response.body));
    } else {
      return const Left('Login gagal');
    }
  }
}
