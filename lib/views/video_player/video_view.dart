import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_youtube_extractor/flutter_youtube_extractor.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  static String routeName = "/VideoView";

  @override
  VideoViewState createState() {
    return VideoViewState();
  }
}

class VideoViewState extends State<VideoView> {
  VideoPlayerController _controller;
  String _outputLink = "";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Player"),
      ),
      body: Column(
        children: <Widget>[
          Chewie(
            _controller,
            aspectRatio: 16 / 9,
            autoPlay: true,
            looping: true,
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> initPlatformState() async {
    _controller = VideoPlayerController.network("");
    try {
      FlutterYoutubeExtractor.getYoutubeMediaLink(
          youtubeLink: 'https://www.youtube.com/watch?v=Llw9Q6akRo4',
          onReceive: (link) {
            if (!mounted) return;
            _playVideo(link);
          });
    } on PlatformException {
      print('Failed to get Youtube Media link.');
    }
  }

  void _playVideo(String link) {
    setState(() {
      _outputLink = link;
      _controller = VideoPlayerController.network(_outputLink);
    });
  }
}
