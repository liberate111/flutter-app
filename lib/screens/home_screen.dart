import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/menu_drawer.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, String> res = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuDrawer(),
      appBar: AppBar(
        title: Image.asset(
          'assets/images/egat_logo.png',
          height: 40,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        actions: [
          IconButton.outlined(
              onPressed: () {}, icon: const Icon(Icons.developer_mode_sharp))
        ],
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(5),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: <Widget>[
          FilledButton(
            onPressed: () {},
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.yellow.shade400)),
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
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.yellow.shade400)),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.telegram_sharp,
                  size: 40,
                ),
                Text('Contact')
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
            onPressed: () {},
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.yellow.shade400)),
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
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.yellow.shade400)),
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
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.yellow.shade400)),
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
    );
  }
}
