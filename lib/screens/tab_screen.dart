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
