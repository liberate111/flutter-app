import 'package:flutter/material.dart';
import 'package:flutter_app/screens/about_screen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/egat_logo.png',height: 50,),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.developer_mode_sharp))
        ],
      ),
      body:  Center(child: ElevatedButton(
        child: const Text('about us'),
        onPressed: () {
          // Get.to(const AboutScreen());
          Get.toNamed('/notfound');
        },
      ),),
    );
  }
}