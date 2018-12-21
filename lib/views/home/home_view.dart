import 'package:flutter/material.dart';
import 'package:flutter_mvp/views/login/login_view.dart';
import 'package:flutter_mvp/views/place_holder.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget {
  static const String routeName = '/Home';

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Column(
          children: [0, 1, 2, 3, 4, 5, 6]
              .map((_) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 48.0,
                          height: 48.0,
                          color: Colors.white,
                        ),
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
    ),
    PlaceholderWidget(Colors.deepOrange),
    PlaceholderWidget(Colors.green),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
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
            icon: new Icon(Icons.group), title: new Text('Users')),
        BottomNavigationBarItem(
            icon: new Icon(Icons.list), title: new Text('Resources')),
        BottomNavigationBarItem(
            icon: Icon(Icons.person), title: Text('Profile'))
      ],
    );
  }
}
