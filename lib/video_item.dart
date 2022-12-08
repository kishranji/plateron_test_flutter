import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class VideoItem extends StatefulWidget {
  int index;

  VideoItem(@required this.index);

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4");
    _controller.initialize().then((value) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade500,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      child: _controller.value.isInitialized
          ? Column(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: VideoPlayer(_controller),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {
                          _controller.play();
                        },
                        icon: Icon(Icons.play_arrow)),
                    IconButton(
                        onPressed: () {
                          _controller.pause();
                        },
                        icon: Icon(Icons.pause)),
                    IconButton(
                        onPressed: () {
                          _controller.pause();
                          _controller.seekTo(Duration.zero);
                        },
                        icon: Icon(Icons.stop)),
                  ],
                )
              ],
            )
          : AspectRatio(
              aspectRatio: 16 / 9,
              child: Center(child: CircularProgressIndicator()),
            ),
    );
  }
}
