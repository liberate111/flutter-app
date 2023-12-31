import 'package:flutter/material.dart';
import 'package:flutter_app/providers/account_provider.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_app/widgets/menu_drawer.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, String> res = {};
  final authService = AuthService();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<AccountProvider>().getAccount());
  }

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      drawer: const MenuDrawer(),
      appBar: AppBar(
        leading: IconButton.outlined(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu)),
        title: Image.asset(
          'assets/images/egat_logo.png',
          height: 40,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        actions: [
          IconButton.outlined(
              onPressed: () async {
                await authService.logout;
                Get.offNamedUntil('/login', (route) => false);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: isPortrait == true ? 1 : 5,
              child: Column(
                children: [
                  Text(
                    'Welcone ${context.watch<AccountProvider>().account?.data?.user?.name}',
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  )
                ],
              )),
          const Divider(),
          Expanded(
            flex: 9,
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(5),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: isPortrait == true ? 3 : 5,
              children: <Widget>[
                FilledButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.yellow.shade400)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: 40,
                      ),
                      Text('Me')
                    ],
                  ),
                ),
                FilledButton.tonal(
                  onPressed: () async {
                    var data = await Get.toNamed('/contact',
                        arguments: {'email': 'test@test.com', 'code': 200});
                    setState(() {
                      res = data;
                    });
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.yellow.shade400)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.telegram_sharp,
                        size: 40,
                      ),
                      Text('Contact\n $res')
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    Get.toNamed('/about');
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.redAccent),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.orange)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.face,
                        size: 40,
                      ),
                      Text('About')
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    Get.toNamed('/news');
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.yellow.shade400)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.newspaper,
                        size: 40,
                      ),
                      Text('News')
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.yellow.shade400)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: 40,
                      ),
                      Text('Me')
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.yellow.shade400)),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: 40,
                      ),
                      Text('Me')
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
