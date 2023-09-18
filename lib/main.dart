import 'package:flutter/material.dart';
import 'package:music_player/screens/home_screen.dart';
import 'package:flutter/services.dart';


void main() {
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
    return MaterialApp(
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

