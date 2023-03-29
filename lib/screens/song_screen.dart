// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable, unused_field

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/streams.dart';
import 'package:worshipapp/models/song_models.dart';
import 'package:worshipapp/widgets/seekbar.dart';
import 'package:rxdart/rxdart.dart' as rxdart;

import '../widgets/widget.dart';

// Spherical coordinate systems
// Radial distance, Polar angel, Azimuth angles

class SongScreen extends StatefulWidget {
  const SongScreen({super.key});

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  Song song = Get.arguments ?? Song.songs[0];

  @override
  void initState() {
    super.initState();

    audioPlayer.setAudioSource(ConcatenatingAudioSource(children: [
      AudioSource.uri(Uri.parse('asset:///${song.url}')),
      AudioSource.uri(Uri.parse('asset:///${Song.songs[1].url}')),
    ]));
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Stream<SeekBarData> get _seekBarDataStream =>
      rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
          audioPlayer.positionStream, 
          audioPlayer.durationStream,
          (Duration position, Duration? duration) {
        return SeekBarData(position, duration ?? Duration.zero);
      });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        extendBodyBehindAppBar: true,
        body: Stack(fit: StackFit.expand, children: [
          Image.asset(
            song.coverUrl,
            fit: BoxFit.cover,
          ),
          _BackGroundFilter(),
          MusicPlayer(
            song: song,
            audioPlayer: audioPlayer,
            seekBarDataStream: _seekBarDataStream,
          )
        ]));
  }
}

class MusicPlayer extends StatelessWidget {
  const MusicPlayer({
    Key? key,
    required this.song,
    required this.audioPlayer,
    required Stream<SeekBarData> seekBarDataStream,
  })  : _seekBarDataStream = seekBarDataStream,
        super(key: key);

  final Song song;
  final AudioPlayer audioPlayer;
  final Stream<SeekBarData> _seekBarDataStream;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            song.title,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            song.description,
            maxLines: 2,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                ),
          ),
          SizedBox(
            height: 30,
          ),
          _BackGroundFilter(),
          StreamBuilder<SeekBarData>(
            stream: _seekBarDataStream,
            builder: (context, snapshot) {
            final positionData = snapshot.data;
            return SeekBar(
              position: positionData?.position ?? Duration.zero,
              duration: positionData?.duration ?? Duration.zero,
              onChangedEnd: audioPlayer.seek,
            );
          }),
          PlayerButtons(audioPlayer: audioPlayer),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton( 
                  onPressed: () {},
                  iconSize: 35,
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {},
                  iconSize: 35,
                  icon: Icon(
                    Icons.cloud_download,
                    color: Colors.white,
                  ))
            ],
          )
        ],
      ),
    );
  }
}

class _BackGroundFilter extends StatelessWidget {
  const _BackGroundFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.5),
              Colors.white.withOpacity(0.0)
            ],
            stops: [
              0.0,
              0.4,
              0.6,
            ]).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomCenter,
                colors: [
              Colors.deepPurple.shade200,
              Colors.deepPurple.shade800,
            ])),
      ),
    );
  }
}
