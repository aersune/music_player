import 'dart:ui';

import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/material.dart';
import 'package:music_player/screens/playing_now_screen.dart';
import 'package:music_player/utils/colors.dart';

import '../models/models.dart';

Widget headingText(text) {
  return Text(text,
      style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColor.secondColor));
}

Widget heading2(text, double fontSize) {
  return Text(text,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          color: AppColor.secondColor));
}

Widget subTitle(
  text,
) {
  return Text(text,
      style: TextStyle(
          fontSize: 10, fontWeight: FontWeight.w400, color: AppColor.subtitle));
}

Widget musicCard(List<Music> list, int index) {
  return ClipRRect(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 200,
          height: 190,
          child: DropShadowImage(
            image: Image.asset(
              list[index].image,
              width: 200,
              height: 190,
              fit: BoxFit.cover,
            ),
            borderRadius: 15,
            blurRadius: 15,
            offset: Offset(0, 35),
            scale: 0.8,
          ),
        ),
        const SizedBox(
          height: 15.19,
        ),
        heading2(list[index].title, 18),
        const SizedBox(
          height: 5.9,
        ),
        subTitle(list[index].subTitle),
      ],
    ),
  );
}

Widget songsBuilder(context, List<Music> list) {
  return Flexible(
    fit: FlexFit.loose,
    child: ListView.builder(
        itemCount: list.length,
        shrinkWrap: true,
        padding: const EdgeInsets.only(left: 28),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 14.3),
            child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MusicPlayer(list: list[index])));
                },
                child: Ink(child: musicCard(list, index))),
          );
        }),
  );
}
