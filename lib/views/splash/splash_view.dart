import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mvp/util/preferences.dart';
import 'package:flutter_mvp/views/home/home_view.dart';
import 'package:flutter_mvp/views/login/login_view.dart';

class Splash extends StatefulWidget {
  @override
  SplashState createState() {
    return SplashState();
  }
}

class SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    splashTimeout();
  }

  splashTimeout() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    String token = await Preferences.getToken();
    if (null == token || token.isEmpty)
      Navigator.of(context).pushReplacementNamed(Login.routeName);
    else
      Navigator.of(context).pushReplacementNamed(Home.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: new Center(child: FlutterLogo(size: 150.0)));
  }
}
