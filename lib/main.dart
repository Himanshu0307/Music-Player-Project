import 'package:flutter/material.dart';
import 'package:project/Login/login.dart';
import 'package:project/Music%20Player/musicplayer.dart';
import 'package:project/Playlist/playlistQueue.dart';
import 'package:project/Recommendation/Recommendation.dart';
import 'package:project/provider/Playlist.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Playlist>(
      create: (context) => Playlist(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  static GlobalKey<ScaffoldState> scstate = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          key: scstate,
          body: TabBarView(children: [
            RecommendationScreen(),
            RecommendationScreen(),
            PlaylistQueue(),
            MusicPlayer()
          ]),
          bottomNavigationBar: const TabBar(tabs: [
            Tab(
              text: "Home",
              icon: Icon(Icons.home),
            ),
            Tab(
              text: "Liked",
              icon: Icon(Icons.favorite_outline),
            ),
            Tab(
              text: "Playlist",
              icon: Icon(Icons.playlist_add),
            ),
            Tab(
              text: "Player",
              icon: Icon(Icons.play_arrow),
            ),
          ]),
        ),
      ),
    );
  }
}
