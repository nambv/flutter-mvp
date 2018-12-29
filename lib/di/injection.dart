import 'package:flutter_mvp/repository/users_repository.dart';
import 'package:flutter_mvp/service/network_service.dart';

class Injector {
  static final Injector _singleton = new Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  UsersRepository get usersRepository {
    return new UsersRepositoryImpl();
  }

  NetworkService get networkService {
    return new NetworkService();
  }
}
