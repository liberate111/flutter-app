import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:get/get.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  final authService = AuthService();
  dynamic profile= {};

  Future<void> getProfile() async {
    var p = await authService.getProfileFromLocal();
    setState(() {
      profile = p;
    });
  }

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/3.PNG'),
              ),
              accountName: Text('${profile['name']}'),
              accountEmail:  Text('${profile['email']} -- ${profile['role']}'),
              onDetailsPressed: () {
                Get.snackbar('app', 'snackbar');
                Scaffold.of(context).closeDrawer();
              }),
          ListTile(
            leading: const Icon(Icons.home_max),
            title: const Text('Home'),
            trailing: const Icon(Icons.arrow_right_rounded),
            onTap: () {
              Get.offNamedUntil('/home', (route) => false);
            },
            // selected: true,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.production_quantity_limits),
            title: const Text('Product'),
            trailing: const Icon(Icons.arrow_right_rounded),
            onTap: () {
              Get.offNamedUntil('/product', (route) => false);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Setting'),
            trailing: const Icon(Icons.arrow_right_rounded),
            onTap: () {
              Get.snackbar('app', 'setting');
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
