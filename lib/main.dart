import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_player/screens/home_screen.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';


Future<void> main() async{
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.example.music_player.channel.audio',
    androidNotificationChannelName: 'Audio Playback',
    androidNotificationOngoing: true,
  );
  runApp(const MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.bottom
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onInit: () async{
        try{
          var status = await Permission.storage.request();
          if(status.isGranted){
            print('isGranted');
          } else if(status.isPermanentlyDenied){
            openAppSettings();
          }
      } catch(e){
          print('~~error~~~>>>>>> $e');
        }
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: AppColor.mainColor),
        // useMaterial3: true,
        fontFamily: 'Gilroy'
      ),
      home: const  HomePage(),
    );
  }
}

