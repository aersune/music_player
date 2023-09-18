import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_player/models/models.dart';
import 'package:music_player/utils/colors.dart';
import 'package:music_player/utils/utils.dart';
import 'package:music_player/widgets/widgets.dart';

import '../widgets/audioinfo.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({Key? key, required this.list}) : super(key: key);

  final  list;

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  bool isPlaying = false;
  late final AudioPlayer player;
  late final AssetSource path;



  Duration _duration = const Duration();
  Duration _position = const Duration();

  @override
  void initState() {
    initPlayer();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future initPlayer() async {
    player = AudioPlayer();
    // path = AssetSource(Music.musics[0].url);
    path = AssetSource(Music.musics[0].url);

    player.onDurationChanged.listen((Duration d) {
      setState(() {
        _duration = d;
      });
    });

    player.onPositionChanged.listen((Duration p) {
      setState(() {
        _position = p;
      });
    });

    player.onPlayerComplete.listen((_) {
      setState(() {
        _position = _duration;
      });
    });
  }

  void playPause() async {
    if (isPlaying) {
      player.pause();
      isPlaying = false;
    } else {
      player.play(path);
      isPlaying = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30,),
              Row(
                children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Padding(
                          padding: EdgeInsets.only(right: 10, bottom: 5),
                          child: SvgPicture.asset('assets/icons/arrow_right.svg')),
                    ),
                  const Spacer(),
                  headingText('Playing Now'),
                  const Spacer(),
                ],
              ),
               const SizedBox(height: 60,),
               AudioInfo(musFile: widget.list),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_position.format(), style: TextStyle(color: AppColor.subtitle)),
                  Text(_duration.format(), style: TextStyle(color: AppColor.subtitle)),
                ],
              ),
              Slider(
                value: _position.inSeconds.toDouble(),
                onChanged: (value) async {
                  await player.seek(Duration(seconds: value.toInt()));
                  setState(() {});
                },
                min: 0,
                max: _duration.inSeconds.toDouble(),
                inactiveColor: Colors.grey,
                activeColor: Colors.white,
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      player.seek(Duration(seconds: _position.inSeconds - 10));
                    },
                    child:  SvgPicture.asset('assets/icons/pack.svg'),
                  ),
                  const SizedBox(width: 37.6),
                  InkWell(
                    onTap: (){
                      playPause();
                    },
                    child: isPlaying ? SvgPicture.asset('assets/icons/pause.svg') :  Icon(  Icons.play_arrow, size: 40, color: AppColor.secondColor),
                  ),
                  const SizedBox(width: 37.6),
                  InkWell(
                    onTap: (){
                      player.seek(Duration(seconds: _position.inSeconds + 10));
                    },
                    child: SvgPicture.asset('assets/icons/next.svg'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
