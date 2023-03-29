class Song {
  final String title;
  final String description;
  final String url;
  final String coverUrl;

  //static var songs;

  Song(
      {required this.title,
      required this.description,
      required this.url,
      required this.coverUrl});

  static List<Song> songs = [
    Song(
        title: 'Song of Angels',
        description: "done by dunsin",
        url: 'assets/music/Song of Angels.mp3',
        coverUrl: 'assets/images/soa.png'),
    Song(
        title: 'Mercy Cry !',
        description: "done by dunsin",
        url: 'assets/music/Oh to Love You.mp3',
        coverUrl: 'assets/images/vic7.png'),
    Song(
        title: 'The Great Revivalist',
        description: "done by dunsin",
        url: 'assets/music/The Great Revivalist.mp3',
        coverUrl: 'assets/images/greatRevivalist.png'),
    Song(
        title: 'Brooding',
        description: "done by dunsin",
        url: 'assets/music/Song of Angels.mp3',
        coverUrl: 'assets/images/vic1.png'),
    Song(
        title: 'I Get Backing',
        description: "done by dunsin",
        url: 'assets/music/Oh to Love You.mp3',
        coverUrl: 'assets/images/vic8.png'),
    Song(
        title: 'when I see You',
        description: "done by dunsin",
        url: 'assets/music/Song of Angels.mp3',
        coverUrl: 'assets/images/crazy.png'),
  ];
}
