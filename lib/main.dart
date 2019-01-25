import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mvp/views/detail/camera_view.dart';
import 'package:flutter_mvp/views/home/home_view.dart';
import 'package:flutter_mvp/views/login/login_view.dart';
import 'package:flutter_mvp/views/splash/splash_view.dart';
import 'package:flutter_mvp/views/video_player/video_view.dart';

List<CameraDescription> cameras;

Future<Null> main() async {
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    //logError(e.code, e.description);
  }

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    availableCameras().then((value) {
      try {
        cameras = value;
        runApp(MyApp());
      } on CameraException catch (e) {
        //logError(e.code, e.description);
      }
    });
  });
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    firebaseCloudMessagingListeners();
  }

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
          },
          VideoView.routeName: (BuildContext context) {
            return VideoView();
          },
          CameraView.routeName: (BuildContext context) {
            return CameraView();
          }
        },
        home: Splash());
  }

  void firebaseCloudMessagingListeners() {
    if (Platform.isIOS) iOSPermission();

    _firebaseMessaging.getToken().then((token) {
      print("token: $token");
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message received: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOSPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}
