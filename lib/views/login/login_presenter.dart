import 'package:flutter_mvp/repository/contacts_repository.dart';
import 'package:flutter_mvp/views/login/login_contract.dart';

class LoginPresenter {
  LoginContract _view;
  ContactsRepository _contactsRepository;

  LoginPresenter(this._view) {
    _contactsRepository = ContactRepositoryImpl();
  }

  void login(String email, String password) {
    _contactsRepository
        .login(email, password)
        .then((_) => _view.onLoginSuccess())
        .catchError((onError) {
      print(onError.toString());
      _view.showError(onError.toString());
    });
  }
}
