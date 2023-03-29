import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worshipapp/models/song_models.dart';

class SongCard extends StatelessWidget {
  const SongCard({
    Key? key,
    required this.song,
  }) : super(key: key);

  final Song song;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.toNamed("/song",arguments: song);
      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        child: Stack(
          alignment: Alignment.bottomCenter, children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image: AssetImage(song.coverUrl), fit: BoxFit.cover),
            ),
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white.withOpacity(0.9)),
            child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,  
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(
                    song.title,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Colors.deepPurple, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    song.description,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.white70, fontWeight: FontWeight.bold),
                  )
                ]),
                Icon(Icons.play_circle,
                color: Colors.deepPurple,)
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
