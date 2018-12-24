import 'package:flutter/material.dart';
import 'package:flutter_mvp/model/user.dart';
import 'package:flutter_mvp/styles/styles.dart';
import 'package:flutter_mvp/views/detail/separator.dart';

class UserContent extends StatelessWidget {
  final User user;
  final bool horizontal;

  UserContent(this.user, {this.horizontal = true});

  UserContent.vertical(this.user) : horizontal = false;

  @override
  Widget build(BuildContext context) {
    final userThumbnail = new Container(
      margin: new EdgeInsets.symmetric(vertical: 16.0),
      alignment:
          horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,
      child: new Hero(
        tag: "planet-hero-${user.id}",
        child: new Container(
            height: 92.0,
            width: 92.0,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: NetworkImage(user.picture.large),
                fit: BoxFit.cover,
              ),
              borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
              border: new Border.all(
                color: Colors.red,
                width: 2.0,
              ),
            )),
      ),
    );

    Widget _userValue({String value, String image}) {
      return new Container(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Icon(Icons.location_on),
            Container(width: 8.0),
            Text(value, style: Style.smallTextStyle),
          ],
        ),
      );
    }

    final userCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(
          horizontal ? 76.0 : 16.0, horizontal ? 16.0 : 42.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment:
            horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(user.name.getFullName(), style: Style.titleTextStyle),
          new Separator(),
          new Row(
            children: <Widget>[
              new Expanded(
                  child: _userValue(
                      value: user.email,
                      image:
                          'https://s3.amazonaws.com/uifaces/faces/twitter/olegpogodaev/128.jpg')),
              new Container(
                width: 32.0,
              ),
              new Expanded(
                  flex: horizontal ? 1 : 0,
                  child: _userValue(
                      value: user.phone,
                      image:
                          'https://s3.amazonaws.com/uifaces/faces/twitter/olegpogodaev/128.jpg'))
            ],
          ),
        ],
      ),
    );

    final userCard = new Container(
      child: userCardContent,
      height: horizontal ? 124.0 : 154.0,
      margin: horizontal
          ? new EdgeInsets.only(left: 46.0)
          : new EdgeInsets.only(top: 72.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );

    return new Container(
      margin: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 24.0,
      ),
      child: new Stack(
        children: <Widget>[
          userCard,
          userThumbnail,
        ],
      ),
    );
  }
}
