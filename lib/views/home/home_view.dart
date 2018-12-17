import 'package:flutter/material.dart';
import 'package:flutter_mvp/model/contact.dart';
import 'package:flutter_mvp/views/detail/detail_view.dart';
import 'package:flutter_mvp/views/home/home_contact.dart';
import 'package:flutter_mvp/views/home/home_presenter.dart';

class Home extends StatelessWidget {
  static const String routeName = '/Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Home')), body: ContactList());
  }
}

class ContactList extends StatefulWidget {
  ContactList({Key key}) : super(key: key);

  @override
  ContactListState createState() {
    return ContactListState();
  }
}

class ContactListState extends State<ContactList> implements HomeContact {
  HomePresenter _presenter;
  List<Contact> _contacts;
  bool _isLoading = false;

  ContactListState() {
    _presenter = new HomePresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    var widget;

    if (_isLoading) {
      widget = new Center(
          child: new Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: new CircularProgressIndicator()));
    } else {
      widget = new ListView(
          padding: new EdgeInsets.symmetric(vertical: 8.0),
          children:
              ListTile.divideTiles(context: context, tiles: _buildContactList())
                  .toList());
    }

    return widget;
  }

  Iterable<ContactItem> _buildContactList() {
    return _contacts.map((contact) => new ContactItem(
          contact: contact,
          onTap: () {
            print("Item clicked: ${contact.imageUrl}");
            Navigator.pushNamed(context, Detail.routeName);
          },
        ));
  }

  @override
  void onContactsReceived(List<Contact> contacts) {
    setState(() {
      _contacts = contacts;
      _isLoading = false;
    });
  }

  @override
  void showError(String message) {
    print(message);
  }
}

class ContactItem extends ListTile {
  ContactItem({Contact contact, GestureTapCallback onTap})
      : super(
            title: new Text(contact.fullName),
            subtitle: new Text(contact.email),
            leading: new Container(
                width: 60.0,
                height: 60.0,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                      image: NetworkImage(contact.imageUrl), fit: BoxFit.cover),
                  borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
                  border: new Border.all(
                    color: Colors.red,
                    width: 2.0,
                  ),
                )),
            onTap: onTap);
}
