import 'package:flutter/material.dart';
import 'package:project/Model/Song.dart';

class Playlist extends ChangeNotifier {
  List<Song> songs = new List.empty();

  void AddSong(Song song, BuildContext context) {
    if (songs.contains(song)) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Already in the Queue")));
    } else {
      songs.add(song);
      notifyListeners();
    }
  }

  void DeleteSong(Song song, BuildContext context) {
    if (!songs.contains(song)) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something went wrong!!")));
    } else {
      songs.remove(song);
      notifyListeners();
    }
  }
}
