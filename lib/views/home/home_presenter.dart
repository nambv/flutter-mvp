import 'package:flutter_mvp/di/injection.dart';
import 'package:flutter_mvp/repository/users_repository.dart';
import 'package:flutter_mvp/views/home/home_contact.dart';

class HomePresenter {
  HomeContact _view;
  ContactsRepository _contactsRepository;

  HomePresenter(this._view) {
    _contactsRepository = new Injector().contactsRepository;
  }

  void loadUsers(int page) {
    if (null == _view) return;

    _contactsRepository
        .fetchUsers(page)
        .then((contacts) => _view.onContactsReceived(contacts))
        .catchError((onError) {
      print(onError);
      _view.showError(onError.toString());
    });
  }
}
