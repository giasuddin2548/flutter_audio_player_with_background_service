
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/utils.dart';

import 'models/Data.dart';
import 'music_controller.dart';
import 'music_helper.dart';

class MusicScreen extends StatelessWidget {
  MusicHelper musicController;
  MusicData musicData;
  MusicScreen(this.musicController, this.musicData, {super.key});

  final MusicController _musicController=Get.put(MusicController());

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    _musicController.make(musicController);
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            height: w*0.8,
            padding: const EdgeInsets.all(8.0),
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(3)),
              child: Image.network(_imageUrlMaker("${musicData.image}"),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.thumb_down_alt_outlined,
                size: 20,
                color: Colors.white,
              ),
              Column(
                children: [
                   Text(
                    musicData.title??'',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    musicData.labelname??'',
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ],
              ),
              const Icon(
                Icons.thumb_up_alt_outlined,
                size: 20,
                color: Colors.white,
              )
            ],
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              height: 3,
              width: MediaQuery.of(context).size.width,

              // child: StreamBuilder(
              //     stream: musicController.player.positionStream,
              //     builder: (c, snap){
              //       if(snap.hasData){
              //         return SliderTheme(data: SliderTheme.of(context).copyWith(
              //           thumbColor: Colors.pink,
              //           thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5.0),
              //
              //
              //
              //           inactiveTrackColor: Colors.grey[400],
              //           activeTrackColor: Colors.pink,
              //
              //
              //           secondaryActiveTrackColor: Colors.pink[300],
              //
              //
              //         ),child: Slider(
              //           value: 20,
              //           secondaryTrackValue: 40.0,
              //           onChanged: (v){},
              //           max: 100,
              //         ));
              //       }else{
              //         return Container();
              //       }
              //     }),



              child: Obx(() => SliderTheme(data: SliderTheme.of(context).copyWith(
                thumbColor: Colors.pink,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5.0),



                inactiveTrackColor: Colors.grey[400],
                activeTrackColor: Colors.pink,


                secondaryActiveTrackColor: Colors.pink[300],


              ),child: Slider(
                value: _musicController.seek.value,
                secondaryTrackValue: _musicController.buffer.value,
                onChanged: (v){},
                max: _musicController.total.value,
              ))),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder(
                    stream: musicController.player.positionStream,
                    builder: (c, snap){
                      if(snap.hasData){
                        return Text(
                          Utils.intToTimeLeft(snap.data?.inSeconds??0),
                          style: TextStyle(color: Colors.grey[400]),
                        );
                      }else{
                        return Text(
                          '0:00',
                          style: TextStyle(color: Colors.grey[400]),
                        );
                      }},),
                StreamBuilder(
                    stream: musicController.player.durationStream,
                    builder: (c, snap){
                      if(snap.hasData){
                        return Text(
                          Utils.intToTimeLeft(snap.data?.inSeconds??0),
                          style: TextStyle(color: Colors.grey[400]),
                        );
                      }else{
                        return Text(
                          '0:00',
                          style: TextStyle(color: Colors.grey[400]),
                        );
                      }},),

              ],
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.shuffle,
                  size: 32,
                  color: Colors.white,
                ),
                InkWell(
                  onTap: (){
                    musicController.seekBackword();
                  },
                  child: const Icon(
                    Icons.skip_previous,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    shape: BoxShape.circle,
                  ),
                  child:  InkWell(
                    onTap: (){
                      musicController.playPause();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: StreamBuilder(
                          stream: musicController.player.playingStream,
                          builder: (c, snap){
                            if(snap.hasData){
                              var playingStatus= snap.data??false;
                              if(playingStatus==true){
                                return const Icon(Icons.pause_rounded,
                                    size: 42,
                                    color: Colors.white,
                                );
                              }else{
                                return const Icon(Icons.play_arrow_rounded,
                                  size: 42,
                                  color: Colors.white,
                                );
                              }
                            }else{
                              return const Icon(Icons.play_arrow,
                                size: 42,
                                color: Colors.white,
                              );
                            }
                          }),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    musicController.seekForward();
                  },
                  child: const Icon(
                    Icons.skip_next,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  onTap: (){
                    musicController.repect();
                  },
                  child: const Icon(
                    Icons.repeat,
                    size: 32,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  String _imageUrlMaker(String s, ) {
    var url=s.replaceAll("<\$size\$>", '300');
    return url;
  }
}
