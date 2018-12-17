import 'package:flutter_mvp/repository/users_repository.dart';
import 'package:flutter_mvp/views/login/login_contract.dart';

class LoginPresenter {
  LoginContract _view;
  UsersRepository _contactsRepository;

  LoginPresenter(this._view) {
    _contactsRepository = UsersRepositoryImpl();
  }

  void login(String email, String password) {
    _contactsRepository
        .login(email, password)
        .then((_) => _view.onLoginSuccess())
        .catchError((onError) {
      // TODO: Handle onError exception
      _view.showError(onError.toString());
    });
  }
}
