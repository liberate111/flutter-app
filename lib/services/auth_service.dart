import 'dart:convert';

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
      return response;
    }
    return response;
  }

  Future<void> logout() async {
    final SharedPreferences pref = await _pref;
    pref.remove('token');
    pref.remove('profile');
  }

  Future<void> getProfile() async {
    final SharedPreferences pref = await _pref;
    var token = json.decode(pref.getString('token')!);
    var accessToken = token['access_token'];
    var url = Uri.parse('https://api.codingthailand.com/api/profile');
    var response =
        await http.get(url, headers: {'Authorization': 'Bearer $accessToken'});
    var resp = json.decode(response.body);
    var profile = resp['data']['user'];
    await pref.setString('profile', json.encode(profile));
  }

  Future<dynamic> getProfileFromLocal() async {
    final SharedPreferences pref = await _pref;
    var profile = json.decode(pref.getString('profile')!);
    return profile; 
  }
}
