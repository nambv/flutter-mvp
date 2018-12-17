import 'package:flutter_mvp/di/injection.dart';
import 'package:flutter_mvp/repository/users_repository.dart';
import 'package:flutter_mvp/views/home/home_contract.dart';

class HomePresenter {
  HomeContract _view;
  UsersRepository _contactsRepository;

  HomePresenter(this._view) {
    _contactsRepository = new Injector().contactsRepository;
  }

  void loadUsers(int page) {
    print("loadUsers: $page");

    if (null == _view) return;

    _contactsRepository
        .fetchUsers(page)
        .then((contacts) => _view.onUsersReceived(contacts))
        .catchError((onError) {
      print(onError);
      _view.showError(onError.toString());
    });
  }
}
