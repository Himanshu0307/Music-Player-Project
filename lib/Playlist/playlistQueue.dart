import 'package:flutter/material.dart';
import 'package:project/provider/Playlist.dart';
import 'package:provider/provider.dart';

class PlaylistQueue extends StatelessWidget {
  const PlaylistQueue({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<Playlist>(builder: (ctx, value, child) {
      return value.songs.isEmpty
          ? Center(
              child: Text("Waiting for your favourite songs..."),
            )
          : ListView.builder(
              itemCount: value.songs.length,
              itemBuilder: (context, ind) {
                return Card(
                  child: ListTile(
                    leading: Image.network(value.songs[ind].ImageUrl),
                    title: Text(value.songs[ind].Title,
                        overflow: TextOverflow.ellipsis),
                    subtitle: Text(value.songs[ind].ArtistName),
                    trailing: SizedBox(
                      width: size.width * 0.4,
                      child: ButtonBar(
                        children: [
                          IconButton(
                              onPressed: () {
                                value.DeleteSong(value.songs[ind]);
                              },
                              icon: Icon(Icons.delete)),
                          IconButton(
                            icon: value.songs[ind] == value.currentPlaying
                                ? Icon(Icons.pause)
                                : Icon(Icons.play_arrow),
                            onPressed: () {
                              value.currentPlaying = value.songs[ind];
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
    });
  }
}
