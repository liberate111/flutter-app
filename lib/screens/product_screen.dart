import 'package:flutter/material.dart';
import 'package:flutter_app/providers/product_provider.dart';
import 'package:flutter_app/widgets/menu_drawer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Future<void>? productFuture;

  @override
  void initState() {
    // var productProvider = Provider.of<ProductProvider>(context, listen: false);
    Future.microtask(
        () => productFuture = context.read<ProductProvider>().getProduct());
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
        body: Consumer<ProductProvider>(
          builder: (context, value, child) {
            return FutureBuilder<void>(
              future: productFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      '${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                } else {
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
                            '${value.productResp?['data']?[index]['picture']}',
                            fit: BoxFit.fill,
                          ),
                        ),
                        title: Text(
                            '${value.productResp?['data']?[index]['title']}'),
                        subtitle: Text(
                            '${value.productResp?['data']?[index]['detail']}'),
                        trailing: Chip(
                          label: Text(
                              '${value.productResp?['data']?[index]['view']}'),
                          padding: const EdgeInsets.all(2),
                          backgroundColor:
                              Theme.of(context).colorScheme.tertiaryContainer,
                        ),
                        onTap: () {
                          Get.toNamed(Uri.parse(
                                  'detail?id=${value.productResp?['data']?[index]['id']}&title=${value.productResp?['data']?[index]['title']}')
                              .toString());
                        },
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: value.productResp!['data']!.length,
                  );
                }
              },
            );
          },
        ));
  }
}
