import 'package:flutter/material.dart';
import 'package:project/Model/Song.dart';
import 'package:project/main.dart';

class Playlist extends ChangeNotifier {
  List<Song> _songs = List.empty(growable: true);

  Song? currentPlaying;

  List<Song> get songs {
    return [..._songs];
  }

  void AddSong(Song song) {
    if (_songs.contains(song)) {
      ScaffoldMessenger.of(MyHomePage.scstate.currentContext!).clearSnackBars();
      ScaffoldMessenger.of(MyHomePage.scstate.currentContext!)
          .showSnackBar(SnackBar(content: Text("Already in the Queue")));
    } else {
      _songs.add(song);
      ScaffoldMessenger.of(MyHomePage.scstate.currentContext!).clearSnackBars();
      ScaffoldMessenger.of(MyHomePage.scstate.currentContext!)
          .showSnackBar(SnackBar(content: Text("Added in the Queue")));
      if (_songs.length == 1) currentPlaying = _songs[0];
      notifyListeners();
    }
  }

  void DeleteSong(Song song) {
    if (!_songs.contains(song)) {
      ScaffoldMessenger.of(MyHomePage.scstate.currentContext!).clearSnackBars();
      ScaffoldMessenger.of(MyHomePage.scstate.currentContext!)
          .showSnackBar(SnackBar(content: Text("Something went wrong!!")));
    } else {
      _songs.remove(song);
      ScaffoldMessenger.of(MyHomePage.scstate.currentContext!).clearSnackBars();
      ScaffoldMessenger.of(MyHomePage.scstate.currentContext!)
          .showSnackBar(SnackBar(content: Text("Removed from the Queue")));
      notifyListeners();
    }
  }
}
