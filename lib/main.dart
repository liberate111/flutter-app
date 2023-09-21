import 'package:flutter/material.dart';
import 'package:flutter_app/screens/about_screen.dart';
import 'package:flutter_app/screens/contact_screen.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:flutter_app/screens/notfound_screen.dart';
import 'package:flutter_app/utils/colors/color_schemes.g.dart';
import 'package:get/get.dart';

import 'screens/camera_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/map_screen.dart';
import 'screens/product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'app',
      theme: ThemeData(
          colorScheme: lightColorScheme,
          useMaterial3: true,
          textTheme: const TextTheme(
              displayLarge: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xffffcc00)),
              titleLarge: TextStyle(
                  fontWeight: FontWeight.bold, fontFamily: 'THSarabunNew'),
              bodyMedium: TextStyle(fontSize: 20, height: 1.2)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 221, 167, 190),
            textStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            foregroundColor: const Color(0xffffcc00),
            padding: const EdgeInsets.all(25),
          ))),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      unknownRoute:
          GetPage(name: '/notfound', page: () => const NotFoundScreen()),
      initialRoute: '/home',
      getPages: [
        GetPage(
            name: '/home',
            page: () => const HomeScreen(),
            transition: Transition.noTransition),
        GetPage(
            name: '/about',
            page: () => const AboutScreen(),
            transition: Transition.native),
        GetPage(name: '/notfound', page: () => const NotFoundScreen()),
        GetPage(
            name: '/contact',
            page: () => const ContactScreen(),
            transition: Transition.native),
        GetPage(
            name: '/product',
            page: () => const ProductScreen(),
            transition: Transition.circularReveal),
        GetPage(
            name: '/detail',
            page: () => const DetailScreen(),
            transition: Transition.circularReveal),
        GetPage(
            name: '/camera',
            page: () => const CameraScreen(),
            transition: Transition.circularReveal),
        GetPage(
            name: '/map',
            page: () => const MapScreen(),
            transition: Transition.circularReveal),
      ],
    );
  }
}
