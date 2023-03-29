//import 'package:worshipapp/models/song_models.dart';

//import 'song_models.dart';



import 'package:worshipapp/models/song_models.dart';

import 'song_models.dart';

class PlayLists{
  final String title;
  final List<Song> songs;
  final String imageUrl;

  PlayLists({
    required this.title,
    required this.songs,
    required this.imageUrl,
  });


  static List<PlayLists> playlist=[
    PlayLists(
    title: 'Praise Music',
    songs: Song.songs,
    imageUrl:'assets/images/SongofAngels.png'),

    PlayLists(
    title: 'Worship Music',
    songs: Song.songs,
    imageUrl:'assets/images/greatRevivalist.png'),

    PlayLists(
    title: 'Roar | Warfare',
    songs: Song.songs,
    imageUrl:'assets/images/oh to love you.png')
  ];
}
