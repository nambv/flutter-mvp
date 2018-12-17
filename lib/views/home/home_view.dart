import 'package:flutter/material.dart';
import 'package:flutter_mvp/model/user.dart';
import 'package:flutter_mvp/views/detail/detail_view.dart';
import 'package:flutter_mvp/views/home/home_contract.dart';
import 'package:flutter_mvp/views/home/home_presenter.dart';
import 'package:flutter_mvp/views/login/login_view.dart';

class Home extends StatelessWidget {
  static const String routeName = '/Home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Home')),
        drawer: createDrawerWidget(context),
        body: UserList());
  }

  Drawer createDrawerWidget(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Drawer Header'),
            decoration: BoxDecoration(color: Colors.blue),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(Login.routeName);
            },
          )
        ],
      ),
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
  ScrollController scrollController;

  void _scrollListener() {
    print(scrollController.position.extentAfter);
    if (scrollController.position.extentAfter == 0) {
      _presenter.loadUsers(++_page);
    }
  }

  UserListState() {
    _presenter = new HomePresenter(this);
  }

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController()..addListener(_scrollListener);
    _page = 1;
    _users = List<User>();
    _isLoading = true;
    _presenter.loadUsers(_page);
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
      widget = ListView.builder(
          controller: scrollController,
          padding: new EdgeInsets.symmetric(vertical: 8.0),
          itemCount: _users.length,
          itemBuilder: (context, index) {
            return _buildUserItem(index);
          });
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
    scrollController.removeListener(_scrollListener);
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
