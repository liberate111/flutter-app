import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotFoundScreen extends StatefulWidget {
  const NotFoundScreen({super.key});

  @override
  State<NotFoundScreen> createState() => _NotFoundScreenState();
}

class _NotFoundScreenState extends State<NotFoundScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '404 Not Found',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.error, fontSize: 40),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                Get.offAll('/home');
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.redAccent),
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
