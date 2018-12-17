import 'package:flutter/material.dart';
import 'package:flutter_mvp/model/contact.dart';

class Detail extends StatelessWidget {
  static const String routeName = '/Detail';
  final Contact contact;

  Detail(this.contact);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(contact.fullName)));
  }
}
