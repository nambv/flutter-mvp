import 'package:flutter/material.dart';
import 'package:flutter_mvp/model/user.dart';
import 'package:flutter_mvp/views/map/map_view.dart';
import 'package:flutter_mvp/views/video_player/video_view.dart';

class Detail extends StatelessWidget {
  static const String routeName = '/Detail';
  final User user;

  Detail(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        Image.network(
          user.picture.large,
          height: 240.0,
          fit: BoxFit.cover,
        ),
        titleSection(),
        buttonSection(context),
        textSection(),
      ],
    ));
  }

  Widget titleSection() {
    return Container(
      // The entire row is in a Container and padded along each edge by 32 pixels.
      padding: const EdgeInsets.all(32.0),
      child: Row(
        children: <Widget>[
          Expanded(
            /**
             * Putting a Column inside an Expanded widget stretches the column to use all remaining free space in the row.
             * Setting the crossAxisAlignment property to CrossAxisAlignment.start positions the column at the start of the row.
             */
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /**
                 * Putting the first row of text inside a Container enables you to add padding.
                 * The second child in the Column, also text, displays as grey.
                 */
                Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    user.name.getFullName(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  user.email,
                  style: TextStyle(color: Colors.grey[500]),
                )
              ],
            ),
          ),
          /**
           * The last two items in the title row are a star icon, painted red, and the text “41”.
           */
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          Text('41')
        ],
      ),
    );
  }

  Widget buttonSection(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Container(
      child: Row(
        // MainAxisAlignment.spaceEvenly: arrange the free space evenly before, between, and after each column
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildButtonColumn(context, color, Icons.call, 'CALL'),
          _buildButtonColumn(context, color, Icons.location_on, 'MAP'),
          _buildButtonColumn(context, color, Icons.share, 'SHARE'),
        ],
      ),
    );
  }

  Widget textSection() {
    return Container(
        padding: const EdgeInsets.all(32.0),
        child: Text(
          'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
              'Alps. Situated 1,578 meters above sea level, it is one of the '
              'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
              'half-hour walk through pastures and pine forest, leads you to the '
              'lake, which warms to 20 degrees Celsius in the summer. Activities '
              'enjoyed here include rowing, and riding the summer toboggan run.',
          softWrap: true,
        ));
  }

  Column _buildButtonColumn(
      BuildContext context, Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(icon),
          color: color,
          onPressed: () {
            switch (label) {
              case 'CALL':
                {}
                break;
              case 'MAP':
                {
                  return Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapView(user.location),
                      ));
                }
                break;
              case 'SHARE':
                {
                  Navigator.of(context).pushNamed(VideoView.routeName);
                }
            }
          },
        ),
        Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        )
      ],
    );
  }

//  requestCallPermission() async {
//    final permission =
//        await Permission.requestSinglePermission(PermissionName.Phone);
//    print(permission);
//  }
}
