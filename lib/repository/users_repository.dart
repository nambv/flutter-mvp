import 'dart:convert';

import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_mvp/api_endpoint.dart';
import 'package:flutter_mvp/di/injection.dart';
import 'package:flutter_mvp/model/user.dart';
import 'package:flutter_mvp/service/network_service.dart';
import 'package:flutter_mvp/util/preferences.dart';
import 'package:flutter_mvp/util/request_exception.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

abstract class UsersRepository {
  Future<List<User>> fetchUsers(int page);

  Observable<void> login(String email, String password);
  Observable<void> logout();
}

class UsersRepositoryImpl implements UsersRepository {
  final NetworkService _networkService = Injector().networkService;
  final JsonDecoder _decoder = new JsonDecoder();

  @override
  Future<List<User>> fetchUsers(int page) async {
    final response = await http.get(ApiEndPoint.RANDOM_USERS +
        "?page=$page&results=10&inc=name,email,gender,picture,location,phone");
    var statusCode = response.statusCode;
    var jsonBody = response.body;

    if (statusCode != 200 || null == statusCode) {
      throw new RequestException(
          "Cannnot fecth data, code: $statusCode, ${response.reasonPhrase}");
    }

    final contactsBody = _decoder.convert(jsonBody);
    final List contacts = contactsBody['results'];

    return contacts.map((contact) => new User.fromJson(contact)).toList();
  }

  @override
  Observable<void> login(String email, String password) {
    Map data = {'email': email, 'password': password};

    return Observable.fromFuture(_networkService.post(ApiEndPoint.LOGIN, data))
        .flatMap((res) {
      if (res.statusCode != 200 || null == res.statusCode) {
        throw new RequestException(
            "Login error, code: ${res.statusCode}, ${res.reasonPhrase}");
      }

      final String token = _networkService.convertJsonToMap(res.body)["token"];
      return Preferences.setToken(token);
    });
  }

  Future<FacebookLoginResult> handleFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult = facebookLogin.logInWithReadPermissions(['email']);
    return facebookLoginResult;
  }

  @override
  Observable<void> logout() {
    return Preferences.clear();
  }
}
