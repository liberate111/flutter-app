import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  Map<String, dynamic> data = {};
  @override
  void initState() {
    data = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Contact ${data['email']} ${data['code']}',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.error, fontSize: 40),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                Get.back(result: {
                  'result_code': '200',
                });
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 100, 94, 94)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange)),
              child: const Text('back to menu'),
            ),
          ],
        ),
      ),
    );
  }
}
