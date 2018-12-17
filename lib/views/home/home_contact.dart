import 'package:flutter_mvp/base/base_contract.dart';
import 'package:flutter_mvp/model/contact.dart';

abstract class HomeContact extends BaseContract {
  void onContactsReceived(List<User> contacts);
}
