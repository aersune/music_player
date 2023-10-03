import 'dart:ui';

import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_player/utils/colors.dart';

class AudioInfo extends StatelessWidget {
  const AudioInfo({Key? key, required this.musFile}) : super(key: key);

  final musFile;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Column(
        children: [
          // Container(
          //   width: 261,
          //   height: 261,
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //         image: AssetImage(
          //           musFile.image,
          //         ),
          //         fit: BoxFit.cover),
          //     borderRadius: BorderRadius.circular(15),
          //   ),
          //   child: BackdropFilter(
          //     filter: ImageFilter.blur(sigmaX: 20, sigmaY: 50),
          //     child: SizedBox(
          //         width: 261,
          //         height: 261,
          //         child: Image.asset(
          //           musFile.image,
          //           fit: BoxFit.cover,
          //         )),
          //   ),
          // ),
          Container(
            width: 261,
            height: 261,
            child: DropShadowImage(
              image: Image.asset(
                musFile.image,
                width: 261,
                height: 261,
                fit: BoxFit.cover,
              ),
              borderRadius: 15,
              blurRadius: 15,
              offset: Offset(0, 10),
              scale: 1.01,
            ),
          ),
          const SizedBox(
            height: 28,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Text(
                    musFile.title,
                    style: TextStyle(
                        fontSize: 30,
                        color: AppColor.secondColor,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    musFile.subTitle,
                    style: TextStyle(fontSize: 16, color: AppColor.subtitle),
                  ),
                ],
              ),
              InkWell(
                child: SvgPicture.asset(
                  'assets/icons/heart.svg',
                  width: 25,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              SvgPicture.asset('assets/icons/volume.svg'),
              const Spacer(),
              SvgPicture.asset('assets/icons/repeat.svg'),
              SvgPicture.asset('assets/icons/shuffle.svg'),
            ],
          )
        ],
      ),
    );
  }
}
