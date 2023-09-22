import 'package:flutter/material.dart';
import 'package:project/Login/login.dart';
import 'package:project/Music%20Player/musicplayer.dart';
import 'package:project/Recommendation/Recommendation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          body: TabBarView(children: [
            RecommendationScreen(),
            RecommendationScreen(),
            RecommendationScreen(),
          ]),
          bottomNavigationBar: TabBar(tabs: [
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
          ]),
        ),
      ),
    );
  }
}
