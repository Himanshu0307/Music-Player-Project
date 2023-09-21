import 'package:flutter/material.dart';

class RecommendationScreen extends StatelessWidget {
  const RecommendationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Top bar
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Enter Song Name",
                          border: OutlineInputBorder()),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child:
                          IconButton(onPressed: null, icon: Icon(Icons.search)))
                ],
              ),
              Text("Recently Played"),
              RecommendedList(),
              Text("Recommended For You"),
              RecommendedList(),
              Text("Liked"),
              RecommendedList(),
            ],
          ),
        ));
  }
}

class RecommendedList extends StatelessWidget {
  List<Map<String, dynamic>> songs = [
    {
      'title': 'Song 1',
      'artist': 'Artist 1',
      'albumArt': 'https://via.placeholder.com/150',
    },
    {
      'title': 'Song 2',
      'artist': 'Artist 2',
      'albumArt': 'https://via.placeholder.com/150',
    },
    {
      'title': 'Song 2',
      'artist': 'Artist 2',
      'albumArt': 'https://via.placeholder.com/150',
    },
    {
      'title': 'Song 2',
      'artist': 'Artist 2',
      'albumArt': 'https://via.placeholder.com/150',
    },
    {
      'title': 'Song 2',
      'artist': 'Artist 2',
      'albumArt': 'https://via.placeholder.com/150',
    },
    {
      'title': 'Song 2',
      'artist': 'Artist 2',
      'albumArt': 'https://via.placeholder.com/150',
    },
    // Add more songs here
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 400,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          final song = songs[index];
          return SizedBox(
            height: 200,
            width: 200,
            child: GridTile(
              child: GridTileBar(
                leading: Image.network(song['albumArt']),
                title: Text(song['title']),
                subtitle: Text(song['artist']),
              ),
            ),
          );
        },
        itemCount: songs.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
