import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Sunackubaru',
      theme: CupertinoThemeData(),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                    color: CupertinoColors.black,
                  ),
            ),
            Text(
              '$_counter',
              style: CupertinoTheme.of(context)
                  .textTheme
                  .navLargeTitleTextStyle
                  .copyWith(
                    color: CupertinoColors.black,
                  ),
            ),
            CupertinoButton(
              onPressed: _incrementCounter,
              child: const Text('Increase'),
            )
          ],
        ),
      ),
    );
  }
}
