import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:music_player/screens/liked_songs_screen.dart';
import 'package:music_player/utils/colors.dart';


class NavMenu extends StatelessWidget {
  const NavMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColor.mainColor,
      child: ListView(
        children: [
          const SizedBox(height: 36,),
          Row(
            children: [
              const SizedBox(width: 31,),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: SvgPicture.asset('assets/icons/close.svg'),
              ),
              const Spacer(),
              InkWell(
                child: SvgPicture.asset('assets/icons/moon.svg'),
              ),
              const SizedBox(width: 19,),
            ],
          ),
          const SizedBox(height: 49,),
          drawerItems('assets/icons/user.svg','Profile'),
          InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LikedSongsScreen()));
              },
              child: drawerItems('assets/icons/heart.svg','Liked Songs')),
          drawerItems('assets/icons/globe_americas.svg','Language'),
          drawerItems('assets/icons/message_text_alt.svg','Contact us'),
          drawerItems('assets/icons/bulb_on.svg','FAQs'),
          drawerItems('assets/icons/cog.svg','Settings'),

        ],
      ),
    );
  }

  Widget drawerItems(String asset,String text){
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, top: 15),
      child: Row(
        children: [
          const SizedBox(width: 25.51,),
          SvgPicture.asset(asset,),
          const SizedBox(width: 30.08,),
          Text(text, style: TextStyle(color: AppColor.secondColor, fontSize: 20, fontWeight: FontWeight.w500),)
        ],
      ),
    );
  }
}
