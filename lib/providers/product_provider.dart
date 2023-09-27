import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  final productService = ProductService();
  Map<String, dynamic>? _productResp;
  Map<String, dynamic>? get productResp => _productResp;

  Future<void> getProduct() async {
    var response =  await productService.getProduct();
    if (response.statusCode == 200) {
      _productResp = json.decode(response.body);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
    notifyListeners();
  }
}
