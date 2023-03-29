// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:worshipapp/models/playlist_models.dart';
import 'package:worshipapp/models/song_models.dart';
import 'package:worshipapp/models/song_models.dart';
import 'package:worshipapp/widgets/playlistCard.dart';

import '../models/song_models.dart';
import '../widgets/widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Song> songs = Song.songs;
  final List<PlayLists> playlist = PlayLists.playlist;
  @override
  Widget build(BuildContext context) {
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
          appBar: _CustomAppBar(),
          bottomNavigationBar: _CustNavBar(),
          body: SingleChildScrollView(
              child: Column(
            children: [
              _DiscoverWidget(),
              _TrendingMusic(),
              playlistMusic(playlist: playlist)
            ],
          )),
        ));
  }
}

class playlistMusic extends StatelessWidget {
  const playlistMusic({
    Key? key,
    required this.playlist,
  }) : super(key: key);

  final List<PlayLists> playlist;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          SectionWidget(title: "PlayLists"),
          ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 20),
              physics: NeverScrollableScrollPhysics(),
              itemCount: playlist.length,
              itemBuilder: (context, index) {
                return PlayListCard(playlist: playlist[index]);
              })
        ],
      ),
    );
  }
}



class _TrendingMusic extends StatelessWidget {
  const _TrendingMusic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: SectionWidget(title: "Trending Music"),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.27,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Song.songs.length,
                itemBuilder: (context, index) {
                  return SongCard(song: Song.songs[index]);
                }),
          ),
        ],
      ),
    );
  }
}

class _DiscoverWidget extends StatelessWidget {
  const _DiscoverWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(
            height: 5,
          ),
          Text('Enjoy your favourite music',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.bold)),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: InputDecoration(
                isDense: true,
                fillColor: Colors.white,
                filled: true,
                hintText: 'search',
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.grey.shade400),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade400,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none)),
          )
        ],
      ),
    );
  }
}

class _CustNavBar extends StatelessWidget {
  const _CustNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.deepPurple.shade800,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outlined),
            label: "favourite",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle_fill_outlined),
            label: "play",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outlined),
            label: "home",
          ),
        ]);
  }
}

class _CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const _CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: Icon(Icons.grid_view_rounded),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 20),
          child: CircleAvatar(
            //backgroundColor: Colors.blue,
            backgroundImage: AssetImage("assets/images/profile.png"),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
