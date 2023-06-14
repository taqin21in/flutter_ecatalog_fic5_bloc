import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  Future<void> saveToken(String token) async {
    final sh = await SharedPreferences.getInstance();
    sh.setString('token', token);
  }

  Future<String> getToken() async {
    final sh = await SharedPreferences.getInstance();
    return sh.getString('token') ?? '';
  }

  Future<bool> removeToken() async {
    final sh = await SharedPreferences.getInstance();
    return sh.remove('token');
  }
}
