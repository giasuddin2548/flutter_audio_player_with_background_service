import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:music_app/music_screen.dart';
import 'models/Data.dart';
import 'music_controller.dart';
import 'music_helper.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var playLink='https://api.shadhinmusic.com/api/v5/streaming/getpth?ptype=S&type=null&ttype=null&name=';
  var artistWiseDataUrl='https://api.shadhinmusic.com/api/v5/Artist/GetArtistContent?id=19';
  var imageUrl='https://shadhinmusiccontent.sgp1.digitaloceanspaces.com/AlbumPreviewImageFile/LalTip_Asif_300.jpg';
  String streamUrl='';
  List<MusicData> artistWiseList=[];
  MusicHelper musicController=MusicHelper();
  var currentPlayingData=MusicData();

  @override
  void initState() {
    getArtistWiseData();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: artistWiseList.length,
          itemBuilder: (c, i){
            var d=artistWiseList[i];
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(_imageUrlMaker(d.image??'')),
              ),
              title: Text(d.title??''),
              subtitle: Text("Total Plays: ${d.totalPlay??''}"),
              onTap: (){
                getMusicLink(d.playUrl??'', d);
              },
            );
          }),
      bottomSheet: myBottomSheet(),
    );
  }

  void getArtistWiseData()async{
    var response=await http.get(Uri.parse(artistWiseDataUrl));
    print(response.statusCode);
    if(response.statusCode ==200){
      var data=jsonDecode(response.body);
      var myMusic=data['data'] as List;
      var n=myMusic.map((e) => MusicData.fromJson(e)).toList();
      artistWiseList.clear();
      setState(() {
        artistWiseList.addAll(n);
      });
    }else{

    }
  }

  myBottomSheet() {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => MusicScreen(musicController, currentPlayingData)));
      },
      child: Container(
        color: Colors.black54,
        height: 60,
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width*0.03,
            right: MediaQuery.of(context).size.width*0.01,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                _imageUrlMaker(currentPlayingData.image??''),
                width: MediaQuery.of(context).size.width*0.1,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.56,
              //color: Colors.green,
             padding:  EdgeInsets.only(left: (MediaQuery.of(context).size.width*0.56)*0.01),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentPlayingData.title??'',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // alignment: Alignment.center,
                        child: Text(
                          '12:30:23',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                        width: (MediaQuery.of(context).size.width*0.56)*0.3,
                        // color: Colors.green,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: (MediaQuery.of(context).size.width*0.56)*0.39,
                        height: 20,
                        child: Slider(
                            value: 10,
                            onChanged: (v){},
                            max: 100,
                          divisions: 5,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        // color: Colors.purpleAccent,
                        width: (MediaQuery.of(context).size.width*0.56)*0.3,
                        child: Text(
                          '12:30',
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                      ),
                    ],
                  ),

                  //  Seekb,
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.3,
              // color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: StreamBuilder(
                        stream: musicController.player.playingStream,
                        builder: (c, snap){
                          if(snap.hasData){
                            var playingStatus= snap.data??false;
                            if(playingStatus==true){
                              return const Icon(Icons.play_arrow_rounded);
                            }else{
                              return const Icon(Icons.pause_rounded);
                            }
                          }else{
                            return const Icon(Icons.play_arrow);
                          }
                        }),
                    onPressed: () {
                      musicController.playPause();
                    },
                    color: Colors.white,
                  ),
                  IconButton(
                    icon: const Icon(Icons.skip_next_rounded),
                    onPressed: () {
                      musicController.playPause();
                    },
                    color: Colors.white,
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  String _imageUrlMaker(String s, ) {
    var url=s.replaceAll("<\$size\$>", '300');
    return url;
  }

  void getMusicLink(String playUrl, MusicData musicData) async{
    var response=await http.get(Uri.parse(playLink+playUrl));
    print(response.statusCode);
    print(response.request?.url);
    if(response.statusCode ==200){
      var data=jsonDecode(response.body);
      streamUrl=data['Data'];
      setState(() {
        setMusic();
        currentPlayingData=musicData;
      });


    }else{

    }
  }

  void setMusic() {
    musicController.setAndPlay(url: streamUrl, musicData: currentPlayingData);
  }
}
