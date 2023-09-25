import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

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
              onPressed: ()  async {
                var phoneNumber = 'tel:0826328164'; //malito: ,sms
                var url = Uri.parse(phoneNumber); 
                await launchUrl(url);
                // Get.back(result: {
                //   'result_code': '200',
                // });
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 100, 94, 94)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(const Color.fromARGB(255, 52, 224, 144))),
              child: const Text('Call'),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: ()  async {
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
