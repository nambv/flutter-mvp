import 'package:flutter_mvp/base/base_contract.dart';
import 'package:flutter_mvp/model/user.dart';

abstract class HomeContract extends BaseContract {
  void onUsersReceived(List<User> users);
}
