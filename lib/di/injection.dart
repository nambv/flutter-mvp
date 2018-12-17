import 'package:flutter_mvp/repository/users_repository.dart';

class Injector {
  static final Injector _singleton = new Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  ContactsRepository get contactsRepository {
    return new ContactRepositoryImpl();
  }
}
