import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_player/models/models.dart';
import 'package:music_player/utils/colors.dart';
import 'package:music_player/widgets/widgets.dart';

class LikedSongsScreen extends StatelessWidget {
  const LikedSongsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 34, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Row(
             children: [
               InkWell(
                   onTap: (){Navigator.pop(context);},
                   child: SvgPicture.asset('assets/icons/arrow_right.svg')),
               const Spacer(),
               SvgPicture.asset('assets/icons/equaliser.svg'),
             ],
           ),
            const SizedBox(height: 30),
            headingText('Liked Songs'),
            const SizedBox(height: 24),
            Flexible(
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: Music.musics.length,
                  gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 3/5,
                    crossAxisCount: 2,
                    mainAxisSpacing: 15.0,
                    crossAxisSpacing: 15.0,
              ), itemBuilder: (context,index){
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius:  BorderRadius.circular(15),
                      onTap: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context) =>  MusicPlayer(list: Music.musics[index],)));
                      },
                      child: Ink(child: musicCard(Music.musics, index))),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
