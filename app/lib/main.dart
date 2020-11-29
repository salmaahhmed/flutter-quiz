import 'package:quiz/di/app_module.dart';
import 'package:quiz/injector.dart';
import 'package:quiz/pages/home_page.dart';
import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:presentation/presentation_index.dart';
import 'package:quiz/services/index.dart';
import 'package:remote/remote.dart';

import 'routing/router.dart';

void main() {
  runApp(Injector(modules: [
    AppModule(),
    RemoteModule(),
    DataModule(),
    DomainModule(),
    PresentationModule(),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey:
          Injector.of(context).inject<NavigationService>().navigatorKey,
      // onUnknownRoute: (settings) => MaterialPageRoute(
      //     builder: (context) => Scaffold(
      //           body: Center(
      //             child: Text('Unknown path'),
      //           ),
      //         )),
      onGenerateRoute: generateRoute,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}
