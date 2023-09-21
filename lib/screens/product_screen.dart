import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/menu_drawer.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDrawer(),
      appBar: AppBar(title: const Text('product'),),
      body: const Text('product'),
    );
  }
}