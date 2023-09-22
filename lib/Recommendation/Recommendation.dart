import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project/Model/Song.dart';
import 'package:http/http.dart' as http;

class RecommendationScreen extends StatelessWidget {
  const RecommendationScreen({super.key});

  Future<List<Song>> getList() {
    // var url = Uri.dataFromString("http://192.168.232.121:5000/getInformation");
    // return http.get(url);
    return Future.delayed(
      Duration(seconds: 2),
      () {
        return ([
          Song(
              0,
              "Sunny Deol",
              "Raju Punjabi",
              "https://www.ie.edu/insights/wp-content/uploads/2020/10/Hindi-Art-for-Busniness-Leaders.jpg",
              ""),
          Song(
              1,
              "Sherfi",
              "Unknown",
              "https://www.ie.edu/insights/wp-content/uploads/2020/10/Hindi-Art-for-Busniness-Leaders.jpg",
              ""),
          Song(
              2,
              "Man Meri",
              "King",
              "https://www.ie.edu/insights/wp-content/uploads/2020/10/Hindi-Art-for-Busniness-Leaders.jpg",
              ""),
          Song(
              3,
              "Heeriye",
              "Unknown",
              "https://www.ie.edu/insights/wp-content/uploads/2020/10/Hindi-Art-for-Busniness-Leaders.jpg",
              ""),
          Song(
              4,
              "Kahani Suno",
              "Unknown",
              "https://www.ie.edu/insights/wp-content/uploads/2020/10/Hindi-Art-for-Busniness-Leaders.jpg",
              "")
        ]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getList(),
        builder: (context, data) {
          print(data.data);
          if (data.connectionState == ConnectionState.done) {
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
                              child: IconButton(
                                  onPressed: null, icon: Icon(Icons.search)))
                        ],
                      ),
                      SizedBox(
                          height: 700, child: SongGrid(songs: (data.data!)))
                    ],
                  ),
                ));
          } else
            return Center(child: CircularProgressIndicator());
        });
  }
}

class SongGrid extends StatelessWidget {
  final List<Song> songs;

  const SongGrid({Key? key, required this.songs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final song = songs[index];
        return SongItem(song: song);
      },
    );
  }
}

class SongItem extends StatelessWidget {
  final Song song;

  const SongItem({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Image.network(song.ImageUrl),
            ListTile(
              title: Text(song.Title),
              subtitle: Text(song.ArtistName),
              trailing: song.isFav
                  ? Icon(Icons.favorite)
                  : Icon(Icons.favorite_outline),
            )
          ],
        ),
      ),
    );
  }
}
