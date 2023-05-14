
import 'package:get/get.dart';
import 'package:music_app/music_helper.dart';

class MusicController extends GetxController{



  var total=0.0.obs;
  var seek=0.0.obs;
  var buffer=0.0.obs;


  void make(MusicHelper musicController)async{
   var po=musicController.player.position.inSeconds;
   seek.value=po.toDouble();

   var du=musicController.player.duration?.inSeconds??0;
   total.value=du.toDouble();
   print('Total: $total');
   var di=musicController.player.bufferedPosition.inSeconds;
   buffer.value=di.toDouble();

  }


}