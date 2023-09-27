import 'dart:convert';

import 'package:flutter_app/models/account/account.dart';
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
    // in class use this
    // var profile = resp['data']['user'];
    // in personal store all of response body
    var profile = resp;
    await pref.setString('profile', json.encode(profile));
  }

  Future<Account> getProfileFromLocal() async {
    final SharedPreferences pref = await _pref;
    var profile = Account.fromJson(json.decode(pref.getString('profile')!));
    return profile;
  }

  Future<http.Response> updateProfile(String name) async {
    final SharedPreferences pref = await _pref;
    var token = json.decode(pref.getString('token')!);
    var accessToken = token['access_token'];
    var url = Uri.parse('https://api.codingthailand.com/api/editprofile');
    var response = await http.post(url,
        headers: {'Authorization': 'Bearer $accessToken'},
        body: {'name': name});

    // save to prefs
    // in class use this
    // var profile = resp['data']['user'];
    // in personal store all of response body
    var resp = json.decode(response.body);
    await pref.setString('profile', json.encode(resp));
    return response;
  }
}
