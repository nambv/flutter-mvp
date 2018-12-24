import 'package:flutter/material.dart';
import 'package:flutter_mvp/model/user.dart';
import 'package:flutter_mvp/styles/styles.dart';
import 'package:flutter_mvp/views/detail/separator.dart';
import 'package:flutter_mvp/views/detail/user_content.dart';

class Detail extends StatelessWidget {
  static const String routeName = '/Detail';
  final User user;

  Detail(this.user);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        constraints: new BoxConstraints.expand(),
        color: Colors.white,
        child: new Stack(
          children: <Widget>[
            _getBackground(),
            _getGradient(),
            _getContent(),
            _getToolbar(context),
          ],
        ),
      ),
    );
  }

  Widget _getBackground() {
    return new Container(
      child: new Image.network(
        "http://images.firstcovers.com/covers/i/its_easy_if_you_try-5332.jpg",
        fit: BoxFit.cover,
        height: 300.0,
      ),
      constraints: new BoxConstraints.expand(height: 300.0),
    );
  }

  Widget _getGradient() {
    return new Container(
      margin: new EdgeInsets.only(top: 190.0),
      height: 110.0,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: <Color>[new Color(0x00736AB7), new Color(0xFF736AB7)],
          stops: [0.0, 0.9],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  Widget _getContent() {
    return new Container(
      child: new ListView(
        padding: new EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 32.0),
        children: <Widget>[
          new UserContent(
            user,
            horizontal: false,
          ),
          new Container(
            color: Colors.white,
            padding: new EdgeInsets.symmetric(horizontal: 32.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  "OVERVIEW",
                  style: Style.headerTextStyle,
                ),
                new Separator(),
                new Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent tellus ante, laoreet at nisl id, gravida tempor lacus. Morbi condimentum iaculis nulla a mollis. Pellentesque pulvinar tellus id turpis maximus, sit amet pharetra mauris imperdiet. Vivamus non condimentum justo. Curabitur eleifend elementum neque at volutpat. Pellentesque arcu lacus, tincidunt et velit nec, sollicitudin placerat lorem. Donec nec dui et nunc finibus fringilla. Sed et cursus sapien. Ut dignissim libero quis turpis rutrum rhoncus. Donec suscipit velit diam, ac consectetur nulla commodo et. Quisque venenatis nisl sed maximus scelerisque. Integer efficitur dapibus urna.\n\nDonec vitae leo eros. Nullam non massa faucibus, aliquet leo quis, faucibus diam. Vivamus non risus ut orci euismod elementum sed quis lectus. Fusce vulputate a justo vel mollis. Nullam aliquet hendrerit mauris, vel eleifend risus bibendum et. Aliquam at lacus in neque rutrum placerat. Morbi eget ultricies arcu, ut convallis ante. Aenean lobortis rhoncus iaculis.\n\nAenean mattis, magna in blandit vulputate, enim tortor gravida justo, nec faucibus metus odio at elit. Duis fermentum odio id metus scelerisque, ac dictum augue elementum. Proin eget viverra nulla. Etiam venenatis nunc eu neque varius ultricies. Praesent elementum arcu at mattis tempus. Duis quis venenatis metus. Phasellus fringilla ornare diam sed semper\n\nPellentesque id erat quis sapien ultricies sodales sed vitae ex. Fusce in egestas magna. Nunc et lectus malesuada, blandit tellus eu, molestie elit. Morbi urna augue, tempor non hendrerit id, lacinia ac mauris. Fusce in finibus risus, vitae luctus ex. Vestibulum accumsan nunc non sem consequat sagittis. Proin maximus, enim vitae pharetra commodo, ante turpis scelerisque nunc, ut laoreet quam justo eu arcu. Suspendisse pharetra erat ut mi consectetur molestie. Cras a blandit ex. Donec consequat, erat vel vehicula ultricies, ipsum libero lobortis diam, nec mollis leo arcu nec erat. Vivamus rhoncus, mauris vel eleifend sollicitudin, odio sapien accumsan tortor, quis dapibus diam erat et quam. Pellentesque ut enim a quam tincidunt congue. Maecenas et mi nec lorem varius vehicula.",
                    style: Style.commonTextStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getToolbar(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: new BackButton(color: Colors.white),
    );
  }
}
