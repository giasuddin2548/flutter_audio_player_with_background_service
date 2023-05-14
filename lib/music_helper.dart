import 'package:just_audio/just_audio.dart';
import 'models/Data.dart';

class MusicHelper{
  final player = AudioPlayer();

  var currentPlayingData=MusicData();
  void setAndPlay({required String url, required MusicData musicData})async{
    currentPlayingData=musicData;
    await  player.setUrl(url);
    await player.play();

  }

  void play()async{
    if(player.playing==false){
      await player.play();
    }

  }

  void playPause()async{
    if(player.playing==false){
      await player.play();
    }else{
      await player.pause();
    }

  }


  void stop()async{
    if(player.playing==true){
      await player.stop();
    }
  }

  void pause()async{
    if(player.playing==true){
      await player.pause();
    }
  }

  void seekForward() async{
      await player.seek(Duration(seconds: player.position.inSeconds+5));
  }

  void seekBackword() async{
    await player.seek(Duration(seconds: player.position.inSeconds-5));
  }

  void repect() async{
    await player.setLoopMode(LoopMode.one);
  }

}