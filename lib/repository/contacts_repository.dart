import 'dart:convert';

import 'package:flutter_mvp/api_endpoint.dart';
import 'package:flutter_mvp/model/contact.dart';
import 'package:flutter_mvp/util/preferences.dart';
import 'package:flutter_mvp/util/request_exception.dart';
import 'package:http/http.dart' as http;

abstract class ContactsRepository {
  Future<List<Contact>> fetchContacts();

  Future<void> login(String email, String password);
}

class ContactRepositoryImpl implements ContactsRepository {
  static const url = 'http://api.randomuser.me/?results=15';
  final JsonDecoder _decoder = new JsonDecoder();

  @override
  Future<List<Contact>> fetchContacts() async {
    final response = await http.get(url);
    var statusCode = response.statusCode;
    var jsonBody = response.body;

    if (statusCode != 200 || null == statusCode) {
      throw new RequestException(
          "Cannnot fecth data, code: $statusCode, ${response.reasonPhrase}");
    }

    final contactsBody = _decoder.convert(jsonBody);
    final List contacts = contactsBody['results'];

    return contacts.map((contact) => new Contact.fromMap(contact)).toList();
  }

  @override
  Future<void> login(String email, String password) async {
    Map data = {'email': email, 'password': password};

    final response = await http.post(ApiEndPoint.LOGIN, body: data);
    var statusCode = response.statusCode;
    var jsonBody = response.body;

    if (statusCode != 200 || null == statusCode) {
      throw new RequestException(
          "Login error, code: $statusCode, ${response.reasonPhrase}");
    }

    final String token = _decoder.convert(jsonBody)['token'];
    await Preferences.setToken(token);
    return;
  }
}
