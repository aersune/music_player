import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart';

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  const PositionData(this.position, this.bufferedPosition, this.duration);
}





class MediaMetadata extends StatelessWidget {
  const MediaMetadata({Key? key, required this.imageUrl, required this.title, required this.artist}) : super(key: key);

  final String imageUrl;
  final String title;
  final String artist;



  @override
  Widget build(BuildContext context) {
    return Column(children: [
      DecoratedBox(decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(2, 4),
            blurRadius: 4
          )
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          height: 300,
          width: 300,
          fit: BoxFit.cover,
        ),
      ),
      ),
      const SizedBox(height: 20,),
      Text(title, style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
      const SizedBox(height: 8,),
      Text(artist, style: TextStyle(color: Colors.white, fontSize: 22, ),textAlign: TextAlign.center,),

    ],);
  }
}





class PlayerAudio extends StatefulWidget {
  const PlayerAudio({Key? key}) : super(key: key);

  @override
  State<PlayerAudio> createState() => _PlayerAudioState();
}

class _PlayerAudioState extends State<PlayerAudio> {
  late AudioPlayer _audioPlayer;

  final _playList  =  ConcatenatingAudioSource(children:  [
     AudioSource.uri(Uri.parse('https://cdndl.zaycev.net/track/24768138/2djvFCs2zpJ6Yvhxd3gTcojvt2Ho4AtctRH2EhGhxYaX6XGQGdyT2H7EummiRQgoxvb2vGoWGNWKxnfnEinbWFC6LZpaqmtyH2Luc7TaehCkLuLP5Nekv6xGeKMiW2uT9CfsZmx1DuxfGFba2AS6RjHhARL1JENzgfDiegHryu2VYJmcGz3wADvxcqbGYrbizmkZ5iyx6HKxRdEbh6UwbZaZiBZ7HujMJjzSMPpHN8Xv9pupdJqVFgzP4Dnd7YtpoxSZQg5ALRi2W4bom27DgthuTsRYp1X3kpwmHvFhNpGo44CptJed9SfDfz8XGzj3CCH1oVEpqZAj2a1Fu5G27ZWw27QpzH5nN1pWC2iT2HWNerrxz6En6nNE56FubpGdNL7e5anRHhU1dLhVrPDTEs1ELaov3w65'),
    tag: MediaItem(id: '0', title: 'nature', artist: 'Public domain', artUri: Uri.parse('https://images.pexels.com/photos/3971985/pexels-photo-3971985.jpeg?auto=compress&cs=tinysrgb&w=1600'))

    ),
    AudioSource.uri(Uri.parse('asset:///assets/audios/believer.mp3'),
    tag: MediaItem(id: '1', title: 'Believer', artist: 'Image Dragons', artUri: Uri.parse('https://images.pexels.com/photos/894156/pexels-photo-894156.jpeg?auto=compress&cs=tinysrgb&w=1600')),
    ),
    AudioSource.uri(
        tag: MediaItem(id: '2', title: 'Ros', artist: 'Heali', artUri: Uri.parse('https://images.pexels.com/photos/1762578/pexels-photo-1762578.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1')),
        Uri.parse('https://cdndl.zaycev.net/track/24353508/4fwmDGCSSQBVQ8wJezPuxJuM2TnraXPoLbgo2Ze2fuZNa7fnYtaWDt2ZF7YMrCxYsRDTdiq5aYzF2csjLiaiCxMF6BQVB4DVuGz2MUwxsL7SMLWacuY8Wi5qR1PQKAE8MmVkUeKtBV1gg6Rp3tgqEC68AMVN79o7kySaFw4t5SkuxH3LAi7QgVTPp34tZb5NWUcqtiyrtp7W5e9mt1RrFLx2pExgrrVEn3PdJmcKtUXwu9TiBLjonaL5AxZpAjSe7MeTaeZk9ewATNGMPpCQBbfEGV3CD19MWbxVnxX9AhJSciVXdxSGGwmBbVLfB156YLwYAUP6HD1952gtYoujWXyMizP6ERapoS47vWJzT1wmd75ukUK5')),

  ]);



  Stream<PositionData> get _positionedDataStream => Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
        (position, bufferedPosition, duration) => PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _audioPlayer = AudioPlayer();
    _init();
  }

  Future<void> _init() async{
    await _audioPlayer.setLoopMode(LoopMode.all);
    await _audioPlayer.setAudioSource(_playList);
  }

  // @override
  // void dispose() {
  //   _audioPlayer.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
          ),
          onPressed: () {},
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
          Color(0xff144771),
          Color(0xff071A2C),
        ])),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<SequenceState?>(stream: _audioPlayer.sequenceStateStream, builder: (context, snapshot){
              final state = snapshot.data;
              if(state?.sequence.isEmpty ?? true){
                return const SizedBox();
              }
              final metadata = state?.currentSource?.tag as MediaItem;
              return MediaMetadata(imageUrl: metadata.artUri.toString(), title: metadata.artist ?? '', artist: metadata.title);
            }),
            StreamBuilder<PositionData>(
                stream: _positionedDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  return ProgressBar(
                      barHeight: 8,
                      baseBarColor: Colors.grey[600],
                      progressBarColor: Colors.red,
                      thumbColor: Colors.red,
                      timeLabelTextStyle: const TextStyle(
                        color: Colors.white,
                        height: 3,
                        fontWeight: FontWeight.w600
                      ),
                      progress: positionData?.position ?? Duration.zero,
                      buffered: positionData?.bufferedPosition ?? Duration.zero,
                      total: positionData?.duration ?? Duration.zero,
                      onSeek: _audioPlayer.seek,
                  );
                }),
            const SizedBox(
              height: 20,
            ),
            Controls(audioPlayer: _audioPlayer)
          ],
        ),
      ),
    );
  }
}

class Controls extends StatelessWidget {
  const Controls({Key? key, required this.audioPlayer}) : super(key: key);

  final AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: audioPlayer.seekToPrevious, icon: const Icon(Icons.skip_previous_rounded), iconSize: 60,color: Colors.white,),
        StreamBuilder<PlayerState>(
            stream: audioPlayer.playerStateStream,
            builder: (context, snapshot) {
              final playerState = snapshot.data;
              final processingState = playerState?.processingState;
              final playing = playerState?.playing;
              if (!(playing ?? false)) {
                return IconButton(onPressed: audioPlayer.play, iconSize: 80, color: Colors.white, icon: Icon(Icons.play_arrow_rounded));
              } else if (processingState != ProcessingState.completed) {
                return IconButton(
                    onPressed: audioPlayer.pause,
                    iconSize: 80,
                    color: Colors.white,
                    icon: const Icon(
                      Icons.pause,
                    ));
              } else {
                return const Icon(
                  Icons.play_arrow_rounded,
                  size: 80,
                  color: Colors.white,
                );
              }
            }),
        IconButton(onPressed: audioPlayer.seekToNext, icon: Icon(Icons.skip_next_rounded), iconSize: 60,color: Colors.white,),
      ],
    );
  }
}
