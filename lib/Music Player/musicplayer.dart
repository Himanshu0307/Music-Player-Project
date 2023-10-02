import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:project/Model/Song.dart';
import 'package:project/main.dart';
import 'package:project/provider/Playlist.dart';
import 'package:provider/provider.dart';

// class MusicPlayer extends StatefulWidget {
//   @override
//   _MusicPlayerState createState() => _MusicPlayerState();
// }

class MusicPlayer extends StatelessWidget {
  List<Song>? playlist;
  Song? currentPlaying;
  double volume = 0.7;
  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    Provider.of<Playlist>(MyHomePage.scstate.currentContext!, listen: false)
        .addListener(() async {
      var prvcurrentPlaying = Provider.of<Playlist>(
          MyHomePage.scstate.currentContext!,
          listen: false);
      if (prvcurrentPlaying.currentPlaying == null) return;
      if (currentPlaying != prvcurrentPlaying.currentPlaying) {
        await player.stop();
        await player.release();
        currentPlaying = prvcurrentPlaying.currentPlaying;
        await player.setSourceUrl(currentPlaying!.StreamUrl);
        await player.resume();
        playlist = prvcurrentPlaying.songs;
      }
    });

    return Column(
      children: [
        (playlist == null || playlist!.isEmpty)
            ? getEmptyPlayer(context)
            : getPlayer(context),
        Flexible(
          fit: FlexFit.loose,
          flex: 3,
          child: playlist != null
              ? ListView.builder(
                  itemCount: playlist!.length,
                  itemBuilder: (context, ind) {
                    return Card(
                      child: ListTile(
                        leading: Image.network(playlist![ind].ImageUrl),
                        title: Text(playlist![ind].Title),
                        subtitle: Text(playlist![ind].ArtistName),
                        trailing: IconButton(
                          icon: playlist?[ind] == currentPlaying
                              ? Icon(Icons.pause)
                              : Icon(Icons.play_arrow),
                          onPressed: () async {},
                        ),
                      ),
                    );
                  })
              : Container(child: Text("Queue is Empty....")),
        )
      ],
    );
  }

  Flexible getEmptyPlayer(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      flex: 4,
      child: Column(
        children: <Widget>[
          // Album art
          Image.network(
            "https://media.tenor.com/pdwuu1tPEH4AAAAM/wave-smile.gif",
          ),

          // Song title
          Text("No Song to play"),

          // // Artist name
          // Text(currentPlaying!.ArtistName),

          // Slider(
          //   value: 0.5,
          //   onChanged: (value) {},
          // ),

          // Prev/nex butt
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.favorite_outline),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.skip_previous),
                onPressed: () {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("No Song to play"),
                    duration: Duration(seconds: 2),
                  ));
                },
              ),
              IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: () {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("No Song to play"),
                    duration: Duration(seconds: 2),
                  ));
                },
              ),
              IconButton(
                icon: Icon(Icons.skip_next),
                onPressed: () {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("No Song to play"),
                    duration: Duration(seconds: 2),
                  ));
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
                              StatefulBuilder(builder: (context, setState) {
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
    );
  }

  Flexible getPlayer(BuildContext context) {
    return Flexible(
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
                  currentPlaying!.isFav = !currentPlaying!.isFav;
                },
              ),
              IconButton(
                icon: Icon(Icons.skip_previous),
                onPressed: () async {
                  // var index = playlist.indexOf(currentPlaying!);
                  // if (index == 0) {
                  //   ScaffoldMessenger.of(context).clearSnackBars();
                  //   ScaffoldMessenger.of(context)
                  //       .showSnackBar(const SnackBar(
                  //     content: Text("Ops!! You are already at starting"),
                  //     duration: Duration(seconds: 2),
                  //   ));
                  // } else {
                  //   await player.stop();
                  //   await player.release();
                  //   currentPlaying = playlist[--index];
                  //   await player.setSourceUrl(currentPlaying!.StreamUrl);
                  //   await player.resume();
                  // }
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
                  // var index = playlist.indexOf(currentPlaying!);
                  // if (index == playlist.length - 1) {
                  //   ScaffoldMessenger.of(context).clearSnackBars();
                  //   ScaffoldMessenger.of(context)
                  //       .showSnackBar(const SnackBar(
                  //     content: Text("End of list...."),
                  //     duration: Duration(seconds: 2),
                  //   ));
                  // } else {
                  //   await player.stop();
                  //   await player.release();
                  //   currentPlaying = playlist[++index];
                  //   await player.setSourceUrl(currentPlaying!.StreamUrl);
                  //   await player.resume();
                  // }
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
                              StatefulBuilder(builder: (context, setState) {
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
    );
  }
}
