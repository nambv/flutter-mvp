import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  static String routeName = "/VideoView";

  @override
  VideoViewState createState() {
    return VideoViewState();
  }
}

class VideoViewState extends State<VideoView> {
  TargetPlatform _platform;
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Player"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Chewie(
                _controller,
                aspectRatio: 3 / 2,
                autoPlay: true,
                looping: true,

                // Try playing around with some of these other options:

                // showControls: false,
                // materialProgressColors: ChewieProgressColors(
                //   playedColor: Colors.red,
                //   handleColor: Colors.blue,
                //   backgroundColor: Colors.grey,
                //   bufferedColor: Colors.lightGreen,
                // ),
                // placeholder: Container(
                //   color: Colors.grey,
                // ),
                // autoInitialize: true,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      _controller = VideoPlayerController.network(
                        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
                      );
                    });
                  },
                  child: Padding(
                    child: Text("Video 1"),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                ),
              ),
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      _controller = VideoPlayerController.network(
                        'https://www.sample-videos.com/video123/mp4/480/big_buck_bunny_480p_20mb.mp4',
                      );
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text("Video 2"),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      _platform = TargetPlatform.android;
                    });
                  },
                  child: Padding(
                    child: Text("Android controls"),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                ),
              ),
              Expanded(
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      _platform = TargetPlatform.iOS;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text("iOS controls"),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

//  void playYoutubeVideo() {
//    FlutterYoutube.playYoutubeVideoByUrl(
//      apiKey: "AIzaSyDKZWodxF-QMfdxdoSwKK4fK1ZpkJ5sN3A",
//      videoUrl: "https://www.youtube.com/watch?v=fhWaJi1Hsfo",
//    );
//    youtube.onVideoEnded.listen((onData) {
//      print(onData);
//    });
//  }

}
