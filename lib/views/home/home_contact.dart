import 'package:flutter_mvp/model/contact.dart';

abstract class HomeContact {
  void onContactsReceived(List<Contact> contacts);
  void showError(String message);
}
