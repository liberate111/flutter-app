import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/firebase_options.dart';
import 'package:flutter_app/providers/account_provider.dart';
import 'package:flutter_app/providers/product_provider.dart';
import 'package:flutter_app/screens/about_screen.dart';
import 'package:flutter_app/screens/contact_screen.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:flutter_app/screens/login_screen.dart';
import 'package:flutter_app/screens/news_screen.dart';
import 'package:flutter_app/screens/notfound_screen.dart';
import 'package:flutter_app/screens/register_screen.dart';
import 'package:flutter_app/screens/tab_screen.dart';
import 'package:flutter_app/screens/web_screen.dart';
import 'package:flutter_app/utils/colors/color_schemes.g.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/camera_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/map_screen.dart';
import 'screens/product_screen.dart';

String? token;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString('token');

  // firebase
  //init firebase app
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //FCM
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AccountProvider()),
      ChangeNotifierProvider(create: (context) => ProductProvider())
    ],
    child: const MyApp(),
  ));
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
            page: () => token == null ? const LoginScreen() : const TabScreen(),
            transition: Transition.noTransition),
        GetPage(
            name: '/tab',
            page: () => const TabScreen(),
            transition: Transition.circularReveal),
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
        GetPage(
            name: '/news',
            page: () => const NewsScreen(),
            transition: Transition.topLevel),
        GetPage(
            name: '/web',
            page: () => const WebScreen(),
            transition: Transition.topLevel),
        GetPage(
            name: '/register',
            page: () => const RegisterScreen(),
            transition: Transition.topLevel),
        GetPage(
            name: '/login',
            page: () => const LoginScreen(),
            transition: Transition.topLevel),
      ],
    );
  }

  //FCM
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await setupFlutterNotifications();
    showFlutterNotification(message);
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    debugPrint('Handling a background message ${message.messageId}');
  }

  /// Create a [AndroidNotificationChannel] for heads up notifications
  late AndroidNotificationChannel channel;

  bool isFlutterLocalNotificationsInitialized = false;

  Future<void> setupFlutterNotifications() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    isFlutterLocalNotificationsInitialized = true;
  }

  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            //      one that already exists in example app.
            icon: 'launch_background',
          ),
        ),
      );
    }
  }

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
}
