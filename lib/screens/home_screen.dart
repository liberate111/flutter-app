import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, String> res = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/egat_logo.png',
          height: 50,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.developer_mode_sharp))
        ],
      ),
      // body:  Center(child: ElevatedButton(
      //   child: const Text('about us'),
      //   onPressed: () {
      //     Get.to(const AboutScreen());
      //   },
      // ),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Home',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.error, fontSize: 40),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () async {
                var data = await Get.toNamed('/contact',
                    arguments: {'email': 'test@test.com', 'code': 200});
                setState(() {
                  res = data;
                });
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.redAccent),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange)),
              child: const Text('contact'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/about');
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.redAccent),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange)),
              child: const Text('about'),
            ),
            Text('data: $res')
          ],
        ),
      ),
    );
  }
}
