import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/menu_drawer.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Future<Map<String, dynamic>>? productFuture;

  Future<Map<String, dynamic>> getData() async {
    var response =
        await http.get(Uri.parse('https://api.codingthailand.com/api/course'));
    if (response.statusCode == 200) {
      Map<String, dynamic> products = json.decode(response.body);
      return products;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    productFuture = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const MenuDrawer(),
        appBar: AppBar(
          title: const Text('product'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: productFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: ConstrainedBox(
                      constraints: const BoxConstraints(
                          maxHeight: 80,
                          minHeight: 80,
                          maxWidth: 80,
                          minWidth: 80),
                      child: Image.network(
                        '${snapshot.data?['data']?[index]['picture']}',
                        fit: BoxFit.fill,
                      ),
                    ),
                    title: Text('${snapshot.data?['data']?[index]['title']}'),
                    subtitle:
                        Text('${snapshot.data?['data']?[index]['detail']}'),
                    trailing: Chip(
                      label: Text('${snapshot.data?['data']?[index]['view']}'),
                      padding: const EdgeInsets.all(2),
                      backgroundColor:
                          Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                    onTap: () {
                      Get.toNamed(Uri.parse(
                              'detail?id=${snapshot.data?['data']?[index]['id']}&title=${snapshot.data?['data']?[index]['title']}')
                          .toString());
                    },
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: snapshot.data!['data']!.length,
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
