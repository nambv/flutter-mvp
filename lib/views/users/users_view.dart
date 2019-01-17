import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mvp/model/user.dart';
import 'package:flutter_mvp/views/detail/detail_view.dart';
import 'package:flutter_mvp/views/users/users_contract.dart';
import 'package:flutter_mvp/views/users/users_presenter.dart';
import 'package:shimmer/shimmer.dart';

class UserList extends StatefulWidget {
  @override
  UserListState createState() {
    return UserListState();
  }
}

class UserListState extends State<UserList> implements UsersContract {
  UsersPresenter _presenter;
  int _page;
  List<User> _users;
  bool _isLoading = false;
  bool _isRefreshing = false;
  bool _isLoadMore = false;
  ScrollController _scrollController;
  Completer<Null> _completer;

  void _scrollListener() {
    print(_scrollController.position.extentAfter);
    if (_scrollController.position.extentAfter == 0) {
      setState(() {
        _isLoadMore = true;
      });
      _presenter.loadUsers(++_page);
    }
  }

  UserListState() {
    _presenter = new UsersPresenter(this);
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

  Widget setupShimmerWidget() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Column(
          children: new List<int>.generate(7, (i) => i + 1)
              .map((_) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: 60.0,
                            height: 60.0,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 16.0,
                                color: Colors.white,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Container(
                                width: double.infinity,
                                height: 16.0,
                                color: Colors.white,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Container(
                                width: 64.0,
                                height: 16.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget setupListViewWidget(BuildContext context) {
    List<Widget> views = <Widget>[
      ListView.builder(
          controller: _scrollController,
          padding: new EdgeInsets.symmetric(vertical: 8.0),
          itemCount: _users.length,
          itemBuilder: (context, index) {
            return _buildUserItem(index, context);
          }),
      Align(
        alignment: Alignment.bottomCenter,
        child: Opacity(
          opacity: _isLoadMore ? 1.0 : 0.0,
          child: Container(
            width: double.infinity,
            height: 42.0,
            padding: EdgeInsets.symmetric(vertical: 4.0),
            color: Colors.white,
            child: Center(
                child: SizedBox(
              child: CircularProgressIndicator(strokeWidth: 3.0),
              height: 20.0,
              width: 20.0,
            )),
          ),
        ),
      ),
    ];

    return Stack(
      children: views,
    );
  }

  /// This method is rerun every time setState is called.
  @override
  Widget build(BuildContext context) {
    var containerWidget;

    if (_isLoading) {
      containerWidget = setupShimmerWidget();
    } else {
      containerWidget = setupListViewWidget(context);
    }

    return new RefreshIndicator(
      child: containerWidget,
      onRefresh: onRefresh,
    );
  }

  UserItem _buildUserItem(int index, BuildContext context) {
    return UserItem(
      user: _users[index],
      onTap: () {
        print("Item clicked: ${_users[index].email}");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Detail(_users[index])));
      },
      context: context,
    );
  }

  @override
  void onUsersReceived(List<User> users) {
    if (!this.mounted) return;

    if (_isRefreshing) {
      _users.clear();
      _completer.complete(null);
      _isRefreshing = false;
    }

    if (users.length > 0) {
      _users.addAll(users);
    }

    setState(() {
      if (_isLoadMore) {
        _isLoadMore = false;
      }
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
  UserItem({User user, GestureTapCallback onTap, BuildContext context})
      : super(
            title: new Text(user.name.getFullName()),
            subtitle: new Text(user.email),
            leading: new Container(
                width: 60.0,
                height: 60.0,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                      image: NetworkImage(user.picture.thumbnail),
                      fit: BoxFit.cover),
                  borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
                  border: new Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2.0,
                  ),
                )),
            onTap: onTap);
}
