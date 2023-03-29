// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:worshipapp/models/song_models.dart';

class PlayerButtons extends StatelessWidget {
  const PlayerButtons({
    Key? key,
    required this.audioPlayer,
  }) : super(key: key);

  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder<SequenceState?>(
            stream: audioPlayer.sequenceStateStream,
            builder: (context, index) {
              return IconButton(
                  onPressed: audioPlayer.hasPrevious
                      ? audioPlayer.seekToPrevious
                      : null,
                  iconSize: 45,
                  icon: Icon(
                    Icons.skip_previous,
                    color: Colors.white,
                  ));
            }),
        StreamBuilder<PlayerState>(
            stream: audioPlayer.playerStateStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final playerState = snapshot.data;
                final processingState = playerState!.processingState;
                if (processingState == ProcessingState.loading ||
                    processingState == ProcessingState.buffering) {
                  return Container(
                    height: 64,
                    width: 64,
                    margin: EdgeInsets.all(10.0),
                    child: CircularProgressIndicator(),
                  );
                } else if (!audioPlayer.playing) {
                  return IconButton(
                      onPressed: audioPlayer.play,
                      iconSize: 75,
                      icon: Icon(
                        Icons.play_circle,
                        color: Colors.white,
                      ));
                } else if (processingState != ProcessingState.completed) {
                  return IconButton(
                      onPressed: audioPlayer.pause,
                      iconSize: 75,
                      icon: Icon(
                        Icons.pause_circle,
                        color: Colors.white,
                      ));
                } else {
                  return IconButton(
                      iconSize: 75,
                      icon: Icon(
                        Icons.replay_circle_filled_outlined,
                        color: Colors.white,
                      ),
                      onPressed: (() => audioPlayer.seek(Duration.zero,
                          index: audioPlayer.effectiveIndices!.first)));
                }
              } else {
                return CircularProgressIndicator();
              }
            }),
        StreamBuilder<SequenceState?>(
            stream: audioPlayer.sequenceStateStream,
            builder: (context, index) {
              return IconButton(
                  onPressed: () => Get.offAllNamed("/song",arguments: Song.songs[1]),
                  //  audioPlayer.hasNext
                  //     ? audioPlayer.seekToNext
                  //     : null,
                  iconSize: 45,
                  icon: Icon(
                    Icons.skip_next,
                    color: Colors.white,
                  ));
            }),
      ],
    );
  }
}
