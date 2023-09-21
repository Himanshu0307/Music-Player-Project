import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:project/Model/Song.dart';

class MusicPlayer extends StatefulWidget {
  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  List<Song> playlist = [
    Song(
        0,
        "Pop",
        "Himanshu",
        "https://www.ie.edu/insights/wp-content/uploads/2020/10/Hindi-Art-for-Busniness-Leaders.jpg",
        "http://192.168.29.221:5000/stream"),
    Song(
        1,
        "Latin",
        "Himanshu1",
        "https://www.ie.edu/insights/wp-content/uploads/2020/10/Hindi-Art-for-Busniness-Leaders.jpg",
        "http://192.168.29.221:5000"),
    Song(
        2,
        "Jazz",
        "Himanshu1",
        "https://www.ie.edu/insights/wp-content/uploads/2020/10/Hindi-Art-for-Busniness-Leaders.jpg",
        "http://mediaserv30.live-streams.nl:8006/live"),
    Song(
        3,
        "Lounge",
        "Himanshu1",
        "https://media.istockphoto.com/id/1183183783/photo/female-artist-works-on-abstract-oil-painting-moving-paint-brush-energetically-she-creates.jpg?s=612x612&w=0&k=20&c=JLPrSmpdzPklAVKycBJ83oPASPfFPS46XvN0TShfLwI=",
        "http://mediaserv30.live-streams.nl:8036/live"),
  ];
  Song? currentPlaying;
  double volume = 0.5;
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    if (playlist.length > 0) {
      currentPlaying = playlist[0];
      player.setSourceUrl(currentPlaying!.StreamUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    player.onPlayerStateChanged.listen((e) => setState(() => {}));
    // player.onPositionChanged.listen((Duration p) => print(p));
    player.onDurationChanged.listen((Duration d) {
    print('Max duration: $d');
  });
  AudioPlayer.global.eventStream.listen((GlobalAudioEvent event) {
    print("event: ${event.eventType}");
  });
    return Scaffold(
      appBar: AppBar(
        title: Text('Music Player'),
        leading: IconButton(
            onPressed: null, icon: Icon(Icons.arrow_back_ios_new_sharp)),
      ),
      body: Column(
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 4,
            child: Column(
              children: <Widget>[
                // Album art
                Image.network(
                  currentPlaying!.ImageUrl,
                ),

                // Song title
                Text(currentPlaying!.Title),

                // Artist name
                Text(currentPlaying!.ArtistName),

                Slider(
                  value: 0.5,
                  onChanged: (value) {},
                ),

                // Prev/nex butt
                ButtonBar(
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(currentPlaying!.isFav
                          ? Icons.favorite
                          : Icons.favorite_outline),
                      onPressed: () {
                        setState(() {
                          currentPlaying!.isFav = !currentPlaying!.isFav;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.skip_previous),
                      onPressed: () async {
                        var index = playlist.indexOf(currentPlaying!);
                        if (index == 0) {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Ops!! You are already at starting"),
                            duration: Duration(seconds: 2),
                          ));
                        } else {
                          await player.stop();
                          await player.release();
                          currentPlaying = playlist[--index];
                          await player.setSourceUrl(currentPlaying!.StreamUrl);
                          await player.resume();
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(player.state.name == "playing"
                          ? Icons.pause
                          : Icons.play_arrow),
                      onPressed: () async {
                        if (await player.state.name == "playing") {
                          await player.pause();
                        } else {
                          await player.resume();
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.skip_next),
                      onPressed: () async {
                        var index = playlist.indexOf(currentPlaying!);
                        if (index == playlist.length - 1) {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("End of list...."),
                            duration: Duration(seconds: 2),
                          ));
                        } else {
                          await player.stop();
                          await player.release();
                          currentPlaying = playlist[++index];
                          await player.setSourceUrl(currentPlaying!.StreamUrl);
                          await player.resume();
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.volume_down_alt),
                      onPressed: () {
                        showBottomSheet(
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                height: 30,
                                child: Row(
                                  children: [
                                    Icon(Icons.volume_down_sharp),
                                    StatefulBuilder(
                                        builder: (context, setState) {
                                      return Slider(
                                          value: volume,
                                          onChanged: (newValue) async {
                                            await player.setVolume(newValue);
                                            setState(() {
                                              volume = newValue;
                                            });
                                          });
                                    })
                                  ],
                                ),
                              );
                            });
                      },
                    ),
                  ],
                ),

                // Seek bar
              ],
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            flex: 3,
            child: playlist.length > 0
                ? ListView.builder(
                    itemCount: playlist.length,
                    itemBuilder: (context, ind) {
                      return Card(
                        child: ListTile(
                          leading: Image.network(playlist[ind].ImageUrl),
                          title: Text(playlist[ind].Title),
                          subtitle: Text(playlist[ind].ArtistName),
                          trailing: IconButton(
                            icon: playlist[ind] == currentPlaying
                                ? Icon(Icons.pause)
                                : Icon(Icons.play_arrow),
                            onPressed: () async {
                              await player.stop();
                              await player.release();
                              setState(() {
                                currentPlaying = playlist[ind];
                              });
                              await player
                                  .setSourceUrl(currentPlaying!.StreamUrl);
                              await player.resume();
                            },
                          ),
                        ),
                      );
                    })
                : Container(child: Text("Queue is Empty....")),
          )
        ],
      ),
    );
  }
}
