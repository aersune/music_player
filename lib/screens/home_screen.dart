import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_player/utils/colors.dart';
import 'package:music_player/widgets/navigation_menu.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../widgets/widgets.dart';




class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  void initState() {
    requestStoragePermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    // var controller = Get.put(PlayerController());

    return Scaffold(
      key: scaffoldKey,
      drawer: const NavMenu(),
      backgroundColor: AppColor.mainColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          Row(children: [
            const SizedBox(width: 18),
            InkWell(
                onTap: () {
                  scaffoldKey.currentState?.openDrawer();
                },
                child: Padding(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), child: SvgPicture.asset('assets/icons/menu.svg'))),
            const Spacer(),
            Padding(padding: const EdgeInsets.all(10), child: SvgPicture.asset('assets/icons/search.svg')),
            const SizedBox(width: 32)
          ]),
          const SizedBox(
            height: 30,
          ),
          Padding(padding: const EdgeInsets.only(left: 28), child: headingText('Recommended for you')),
          const SizedBox(height: 11.21),
          FutureBuilder<List<SongModel>>(
              future: _audioQuery.querySongs(
                ignoreCase: true,
                orderType: OrderType.ASC_OR_SMALLER,
                sortType: null,
                uriType: UriType.EXTERNAL,
              ),
              builder: (BuildContext context, snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text(
                    'No Songs found',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ));
                }   return Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data![index].title),
                          subtitle: Text(snapshot.data![index].displayName),
                          trailing: const Icon(Icons.more_vert),
                          leading: QueryArtworkWidget(id: snapshot.data![index].id, type: ArtworkType.ARTIST),
                        );
                      }),
                );
              }),
          // Padding(padding: const EdgeInsets.only(left: 28), child: headingText('My Playlist')),
          // const SizedBox(height: 20),
          // songsBuilder(context, Music.musics),
        ],
      ),
    );
  }

  void requestStoragePermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }

      setState(() {});
    }
  }
}
