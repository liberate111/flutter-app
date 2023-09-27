import 'package:flutter/material.dart';
import 'package:flutter_app/providers/account_provider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Consumer<AccountProvider>(
            builder: (context, value, child) {
              return UserAccountsDrawerHeader(
                  currentAccountPicture: const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/3.PNG'),
                  ),
                  accountName: Text('${value.account?.data?.user?.name}'),
                  accountEmail: Text(
                      '${value.account?.data?.user?.email} -- ${value.account?.data?.user?.role}'),
                  onDetailsPressed: () {
                    Get.snackbar('app', 'update profile');
                    // method 1
                    // context.read<AccountProvider>().updateProfile('welcome Bro!');
                    // method 2
                    Provider.of<AccountProvider>(context, listen: false)
                        .updateWelcomeName('welcome Sis!');
                    Provider.of<AccountProvider>(context, listen: false)
                        .updateProfile('newName');
                    Scaffold.of(context).closeDrawer();
                  });
            },
          ),
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
