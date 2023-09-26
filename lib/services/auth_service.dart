import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  Future<http.Response> register({
    required String name,
    required String email,
    required String password,
  }) async {
    var url = Uri.parse('https://api.codingthailand.com/api/register');
    var response = await http.post(url, body: {
      "name": name,
      "email": email,
      "password": password,
    });
    return response;
  }

  Future<http.Response> login({
    required String email,
    required String password,
  }) async {
    var url = Uri.parse('https://api.codingthailand.com/api/login');
    var response = await http.post(url, body: {
      "email": email,
      "password": password,
    });

    if (response.statusCode == 200) {
      final SharedPreferences pref = await _pref;
      pref.setString('token', response.body);
    }
    return response;
  }
}
