import 'package:flutter_mvp/di/injection.dart';
import 'package:flutter_mvp/repository/users_repository.dart';
import 'package:flutter_mvp/views/users/users_contract.dart';

class UsersPresenter {
  UsersContract _view;
  UsersRepository _usersRepository;

  UsersPresenter(this._view) {
    _usersRepository = new Injector().usersRepository;
  }

  void loadUsers(int page) {
    print("loadUsers: $page");

    if (null == _view) return;

    _usersRepository
        .fetchUsers(page)
        .then((contacts) => _view.onUsersReceived(contacts))
        .catchError((onError) {
      print(onError);
      _view.showError(onError.toString());
    });
  }
}
