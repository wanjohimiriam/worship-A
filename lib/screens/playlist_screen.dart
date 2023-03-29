// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../models/playlist_models.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  @override
  Widget build(BuildContext context) {
    PlayLists playlist = PlayLists.playlist[0];
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomCenter,
                colors: [
              Colors.deepPurple.shade800.withOpacity(0.8),
              Colors.deepPurple.shade200.withOpacity(0.8),
            ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: Center(child: Text('PlayList')),
          ),
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                playcover(playlist: playlist),
                SizedBox(
                  height: 20,
                ),
                playShuffle(),
                playlistSongWidget(playlist: playlist)
              ],
            ),
          )),
        ));
  }
}

class playlistSongWidget extends StatelessWidget {
  const playlistSongWidget({
    Key? key,
    required this.playlist,
  }) : super(key: key);

  final PlayLists playlist;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: playlist.songs.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(
              '${index + 1}',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            title: Text(
              playlist.songs[index].title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "${playlist.songs[index].description}"
            ),
           trailing: Icon(
            Icons.more_vert,
            color: Colors.white,
           ),
          );
        });
  }
}

class playShuffle extends StatefulWidget {
  const playShuffle({
    Key? key,
  }) : super(key: key);

  @override
  State<playShuffle> createState() => _playShuffleState();
}

class _playShuffleState extends State<playShuffle> {
  bool is_play = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        setState(() {
          is_play = !is_play;
        });
      },
      child: Container(
        height: 50,
        width: width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
        child: Stack(children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            left: is_play ? 0 : width * 0.45,
            child: Container(
                height: 50,
                width: width * 0.45,
                decoration: BoxDecoration(
                    color: Colors.deepPurple.shade400,
                    borderRadius: BorderRadius.circular(15.0))),
          ),
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text('play',
                          style: TextStyle(
                            color: is_play ? Colors.white : Colors.deepPurple,
                            fontSize: 17,
                          )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.play_circle,
                        color: is_play ? Colors.white : Colors.deepPurple),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text('shuffle',
                          style: TextStyle(
                            color: is_play ? Colors.deepPurple : Colors.white,
                            fontSize: 17,
                          )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.shuffle,
                        color: is_play ? Colors.deepPurple : Colors.white),
                  ],
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}

class playcover extends StatelessWidget {
  const playcover({
    Key? key,
    required this.playlist,
  }) : super(key: key);

  final PlayLists playlist;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.asset(
              playlist.imageUrl,
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.5,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            playlist.title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          )
        ],
      ),
    );
  }
}
