import 'dart:convert';

import 'package:flutter_mvp/model/contact.dart';
import 'package:flutter_mvp/util/request_exception.dart';
import 'package:http/http.dart' as http;

abstract class ContactsRepository {
  Future<List<Contact>> fetchContacts();
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
}
