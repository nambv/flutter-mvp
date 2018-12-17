import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mvp/views/home/home_view.dart';
import 'package:flutter_mvp/views/login/login_view.dart';
import 'package:flutter_mvp/views/splash/splash_view.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        routes: <String, WidgetBuilder>{
          Home.routeName: (BuildContext context) {
            return Home();
          },
          Login.routeName: (BuildContext context) {
            return Login();
          }
        },
        home: Splash());
  }
}
