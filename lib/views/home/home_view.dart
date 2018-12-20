import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mvp/model/user.dart';
import 'package:flutter_mvp/views/detail/detail_view.dart';
import 'package:flutter_mvp/views/home/home_contract.dart';
import 'package:flutter_mvp/views/home/home_presenter.dart';
import 'package:flutter_mvp/views/login/login_view.dart';

class Home extends StatefulWidget {
  static const String routeName = '/Home';

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Home')),
        drawer: setupDrawerWidget(context),
        body: UserList(),
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
                        "https://cdn.hipwallpaper.com/i/54/15/rWvKjQ.jpg"),
                    fit: BoxFit.cover)),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(Login.routeName);
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
            icon: new Icon(Icons.home), title: new Text('Home')),
        BottomNavigationBarItem(
            icon: new Icon(Icons.mail), title: new Text('Messages')),
        BottomNavigationBarItem(
            icon: Icon(Icons.person), title: Text('Profile'))
      ],
    );
  }
}

class UserList extends StatefulWidget {
  @override
  UserListState createState() {
    return UserListState();
  }
}

class UserListState extends State<UserList> implements HomeContract {
  HomePresenter _presenter;
  int _page;
  List<User> _users;
  bool _isLoading = false;
  bool _isRefreshing = false;
  ScrollController _scrollController;
  Completer<Null> _completer;

  void _scrollListener() {
    print(_scrollController.position.extentAfter);
    if (_scrollController.position.extentAfter == 0) {
      _presenter.loadUsers(++_page);
    }
  }

  UserListState() {
    _presenter = new HomePresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _scrollController = new ScrollController()..addListener(_scrollListener);
    _page = 1;
    _users = List<User>();
    _isLoading = true;
    _presenter.loadUsers(_page);
  }

  Future<Null> onRefresh() {
    _completer = new Completer<Null>();
    _isRefreshing = true;
    _page = 1;
    _presenter.loadUsers(_page);
    return _completer.future;
  }

  /// This method is rerun every time setState is called.
  @override
  Widget build(BuildContext context) {
    var widget;

    if (_isLoading) {
      widget = new Center(
          child: new Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: new CircularProgressIndicator()));
    } else {
      widget = new RefreshIndicator(
          child: ListView.builder(
              controller: _scrollController,
              padding: new EdgeInsets.symmetric(vertical: 8.0),
              itemCount: _users.length,
              itemBuilder: (context, index) {
                return _buildUserItem(index);
              }),
          onRefresh: onRefresh);
    }

    return widget;
  }

  UserItem _buildUserItem(int index) {
    return UserItem(
        user: _users[index],
        onTap: () {
          print("Item clicked: ${_users[index].avatar}");
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Detail(_users[index])));
        });
  }

  @override
  void onUsersReceived(List<User> users) {
    if (_isRefreshing) {
      _users.clear();
      _completer.complete(null);
      _isRefreshing = false;
    }

    if (users.length > 0) {
      _users.addAll(users);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void showError(String message) {
    print(message);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }
}

class UserItem extends ListTile {
  UserItem({User user, GestureTapCallback onTap})
      : super(
            title: new Text(user.getFullName()),
            subtitle: new Text(user.id.toString()),
            leading: new Container(
                width: 60.0,
                height: 60.0,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                      image: NetworkImage(user.avatar), fit: BoxFit.cover),
                  borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
                  border: new Border.all(
                    color: Colors.red,
                    width: 2.0,
                  ),
                )),
            onTap: onTap);
}
