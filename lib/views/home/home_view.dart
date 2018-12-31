import 'package:flutter/material.dart';
import 'package:flutter_mvp/views/home/home_contract.dart';
import 'package:flutter_mvp/views/home/home_presenter.dart';
import 'package:flutter_mvp/views/login/login_view.dart';
import 'package:flutter_mvp/views/place_holder.dart';
import 'package:flutter_mvp/views/users/users_view.dart';

class Home extends StatefulWidget {
  static const String routeName = '/Home';

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> implements HomeContract {
  HomePresenter _presenter;
  int _currentIndex = 0;
  final List<Widget> _children = [
    UserList(),
    PlaceholderWidget(Colors.deepOrange),
    PlaceholderWidget(Colors.green),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _presenter = HomePresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Home')),
        body: _children[_currentIndex],
        drawer: setupDrawerWidget(context),
        bottomNavigationBar: setupBottomNavigationBar());
  }

  Drawer setupDrawerWidget(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: new Text(
              "Nam Bui Vu",
              style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            accountEmail: new Text(
              "nambuivu@gmail.com",
              style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
            ),
            currentAccountPicture: new CircleAvatar(
                backgroundImage: new NetworkImage(
                    'https://s3.amazonaws.com/uifaces/faces/twitter/olegpogodaev/128.jpg')),
            decoration: BoxDecoration(
                image: new DecorationImage(
                    image: NetworkImage(
                        "https://hsto.org/files/87c/913/f5f/87c913f5fa3a4d4c807efbcccfa047f7.jpg"),
                    fit: BoxFit.cover)),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              _presenter.logout();
            },
          )
        ],
      ),
    );
  }

  BottomNavigationBar setupBottomNavigationBar() {
    return BottomNavigationBar(
      onTap: onTabTapped, // new
      currentIndex: _currentIndex,
      items: [
        BottomNavigationBarItem(
            icon: new Icon(Icons.group), title: new Text('Users')),
        BottomNavigationBarItem(
            icon: new Icon(Icons.list), title: new Text('Resources')),
        BottomNavigationBarItem(
            icon: Icon(Icons.person), title: Text('Profile'))
      ],
    );
  }

  @override
  void onLoggedOut() {
    Navigator.of(context).pushReplacementNamed(Login.routeName);
  }

  @override
  void showError(String message) {}
}
