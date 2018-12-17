import 'package:flutter/material.dart';
import 'package:flutter_mvp/model/user.dart';

class Detail extends StatelessWidget {
  static const String routeName = '/Detail';
  final User user;

  Detail(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(user.getFullName())));
  }
}
