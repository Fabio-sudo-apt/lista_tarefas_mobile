import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:taredas_api/model/video.dart';
import 'package:taredas_api/views/routes/video_build.dart';
import 'package:taredas_api/views/util/appBar.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class HomeVideo extends StatefulWidget {
  const HomeVideo({Key? key}) : super(key: key);

  @override
  State<HomeVideo> createState() => _HomeVideoState();
}

class _HomeVideoState extends State<HomeVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Video Play"),
      backgroundColor: const Color(0xff1CB273),
      body: FutureBuilder(
        future: fetch(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    "Error no carregamento do Video...",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color(0xFFFFE0B2),
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length ?? 0,
                  itemBuilder: (context, index) {
                    final video = snapshot.data![index];
                    return Column(
                      children: [
                        VideoBuid(
                          looping: true,
                          controller: VideoPlayerController.network(video.video),
                        )
                      ],
                    );
                  },
                );
              }
          }
        },
      ),
    );
  }

  Future<List<Video>> fetch() async {
    List<Video> toDataList = [];
    final uri = Uri.parse("https://61ec81e2f3011500174d2193.mockapi.io/videos");
    final response = await http.get(uri);
    final body = jsonDecode(response.body);
    for (int i = 0; i < body.length; i++) {
      toDataList.add(Video.fromJson(body[i]));
    }
    return toDataList;
  }
}
