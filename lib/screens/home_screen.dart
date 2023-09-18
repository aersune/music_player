import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_player/utils/colors.dart';
import 'package:music_player/widgets/navigation_menu.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      drawer: const NavMenu(),
      backgroundColor: AppColor.mainColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 40,),
          Row(children: [
            const SizedBox(width: 18),
            InkWell(
                onTap: () {
                  scaffoldKey.currentState?.openDrawer();
                },
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: SvgPicture.asset('assets/icons/menu.svg'))),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(10),
                child: SvgPicture.asset('assets/icons/search.svg')), const SizedBox(width: 32)

          ]),
          const SizedBox(height: 30,),
          Padding(padding: const EdgeInsets.only(left: 28), child: headingText('Recommended for you')),
          const SizedBox(height: 11.21),
          songsBuilder(context, Music.recommended),
          Padding(padding: const EdgeInsets.only(left: 28), child: headingText('My Playlist')),
          const SizedBox(height: 20),
          songsBuilder(context, Music.musics),
        ],
      ),
    );
  }
}
