import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/camera_screen.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:flutter_app/screens/map_screen.dart';
import 'package:flutter_app/widgets/menu_drawer.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller = TabController(length: 3, vsync: this);

  final firebaseMessaging = FirebaseMessaging.instance;

  // void showFlutterNotification(RemoteMessage.event) {
    // Get.defaultDialog(
    //   title: Text('${event.notification!.body}'),
    //   content: Text('${event.notification!.body}'),
    //   actions: [
    //     OutlinedButton(onPressed: onPressed, child: child)
    //   ]
    // )
  // }

  @override
  void initState() {
    firebaseMessaging.getToken().then((value) => {
      debugPrint('FCM Token: $value')
    });

    FirebaseMessaging.onMessage.listen(showFlutterNotification);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const MenuDrawer(),
        body: TabBarView(
          controller: controller,
          children: const [HomeScreen(), CameraScreen(), MapScreen()],
        ),
        bottomNavigationBar: Material(
          color: Colors.pinkAccent,
          child: TabBar(
            controller: controller,
            tabs: const <Tab>[
              Tab(
                height: 80,
                icon: Icon(Icons.holiday_village),
                text: 'Home',
              ),
              Tab(
                height: 80,
                icon: Icon(Icons.camera_front),
                text: 'Camera',
              ),
              Tab(
                height: 80,
                icon: Icon(Icons.map),
                text: 'Map',
              )
            ],
          ),
        ));
  }
}
