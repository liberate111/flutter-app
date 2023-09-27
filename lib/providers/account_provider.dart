import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/models/account/account.dart';
import 'package:flutter_app/services/auth_service.dart';

class AccountProvider extends ChangeNotifier {
  final authService = AuthService();

  String _welcome = 'welcome back!';
  String get welcome => _welcome;

  Account? _account;
  Account? get account => _account;

  Future<void> getAccount() async {
    var acc = await authService.getProfileFromLocal();
    _account = acc;
    notifyListeners();
  }

  void updateWelcomeName(String name) {
    _welcome = name;
    notifyListeners();
  }

  Future<void> updateProfile(String name) async {
    var response = await authService.updateProfile(name);
    if (response.statusCode == 200) {
      var resp = json.decode(response.body);
      _account = Account.fromJson(resp);
    }
    notifyListeners();
  }
}
