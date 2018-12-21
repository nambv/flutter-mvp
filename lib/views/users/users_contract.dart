import 'package:flutter_mvp/base/base_contract.dart';
import 'package:flutter_mvp/model/user.dart';

abstract class UsersContract extends BaseContract {
  void onUsersReceived(List<User> users);
}
