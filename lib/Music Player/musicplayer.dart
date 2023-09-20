import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MusicPlayer extends StatefulWidget {
  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  final url = "http://mediaserv30.live-streams.nl:8088/live";
  final player = AudioPlayer();

  @override
   void  initState() {
    // TODO: implement initState
    super.initState();
    player.setSourceUrl(url);
    

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Player'),
        leading: IconButton(
            onPressed: null, icon: Icon(Icons.arrow_back_ios_new_sharp)),
      ),
      body: Column(
        children: <Widget>[
          // Album art
          Placeholder(),

          // Song title
          Text('Song Title'),

          // Artist name
          Text('Artist Name'),

          Slider(
            value: 0.5,
            onChanged: (value) {},
          ),

          // Prev/nex butt
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.repeat),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.skip_previous),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.skip_next),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.volume_down_alt),
                onPressed: () {},
              ),
            ],
          ),

          // Seek bar
        ],
      ),
    );
  }
}
