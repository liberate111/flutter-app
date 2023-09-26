import 'package:http/http.dart' as http;
// import 'package:get/get.dart';
// import 'dart:convert';

class AuthService {
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
}
