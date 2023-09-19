import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/app_header.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  var staff = {'address': 'BKK'};
  var site = 'NBK0';
  void _incrementCounter() {
    setState(() {
      _counter++;
      site = 'SBK0';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        title: Image.asset('assets/images/egat_logo.png', height: 40,),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const AppHeader(
              title: 'test',
            ),
            Text(
              'fufuu ',
              style: TextStyle(
                  backgroundColor:
                      Theme.of(context).colorScheme.tertiaryContainer,
                  fontSize: 40),
            ),
            Text(
              'You have pushed the button this many times:',
              style: TextStyle(
                  backgroundColor: Theme.of(context).colorScheme.secondary),
            ),
            Text(
              '$_counter ${staff['address']} $site',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
