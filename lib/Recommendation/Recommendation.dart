import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project/Model/Song.dart';
import 'package:http/http.dart' as http;
import 'package:project/provider/Playlist.dart';
import 'package:provider/provider.dart';

class RecommendationScreen extends StatelessWidget {
  RecommendationScreen({super.key});

  Future<List<Song>> getList() {
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

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getList(),
        builder: (context, data) {
          if (data.connectionState == ConnectionState.done) {
            // var songlist = data.data;
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
                              controller: _controller,
                              onChanged: (value) {},
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
                          height: 700,
                          child: SongGrid(
                            songs: (data.data!),
                            controller: _controller,
                          ))
                    ],
                  ),
                ));
          } else
            return Center(child: CircularProgressIndicator());
        });
  }
}

class SongGrid extends StatefulWidget {
  final List<Song> songs;
  final TextEditingController controller;

  const SongGrid({Key? key, required this.songs, required this.controller})
      : super(key: key);

  @override
  State<SongGrid> createState() => _SongGridState();
}

class _SongGridState extends State<SongGrid> {
  late List<Song> songs = widget.songs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initialised");
    widget.controller.addListener(() {
      setState(() {
        songs = widget.songs
            .where(
              (element) => element.Title.toLowerCase()
                  .contains(widget.controller.text.toLowerCase()),
            )
            .toList();
      });
    });
  }

  @override
  void dispose() {
    print("sfdsfsfsfsdfs");
    // TODO: implement dispose
    widget.controller.removeListener(() {});
    super.dispose();
  }

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
      onTap: () {
        Provider.of<Playlist>(context, listen: false).AddSong(song);
      },
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
            StatefulBuilder(builder: (context, setState) {
              return ListTile(
                  title: Text(song.Title),
                  subtitle: Text(song.ArtistName),
                  trailing: InkWell(
                    child: song.isFav
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_outline),
                    onTap: () {
                      setState(() {
                        song.isFav = !song.isFav;
                      });
                    },
                  ));
            })
          ],
        ),
      ),
    );
  }
}
