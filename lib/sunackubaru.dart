import 'package:flutter/cupertino.dart';

class Sunackubaru extends StatelessWidget {
  const Sunackubaru({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Sunackubaru',
      theme: CupertinoThemeData(),
      home: _SunackubaruHomePage(),
    );
  }
}

class _SunackubaruHomePage extends StatefulWidget {
  const _SunackubaruHomePage();

  @override
  State<_SunackubaruHomePage> createState() => __SunackubaruHomePageState();
}

class __SunackubaruHomePageState extends State<_SunackubaruHomePage> {
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
