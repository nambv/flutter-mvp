import 'package:flutter_mvp/di/injection.dart';
import 'package:flutter_mvp/repository/users_repository.dart';
import 'package:flutter_mvp/views/home/home_contract.dart';

class HomePresenter {
  HomeContract _view;
  UsersRepository _usersRepository;

  HomePresenter(this._view) {
    _usersRepository = new Injector().usersRepository;
  }

  void logout() {
    _usersRepository.logout().listen((_) {
      _view.onLoggedOut();
    }).onError((error) {
      _view.showError(error.toString());
    });
  }
}
