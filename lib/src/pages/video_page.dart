import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';



class VideoPage extends StatefulWidget {

  final String video;

  VideoPage({@required this.video});

  @override
  _VideoPageState createState() => _VideoPageState(video);
}

class _VideoPageState extends State<VideoPage> {
  String video;
  _VideoPageState(this.video);
  YoutubePlayerController _controller = YoutubePlayerController();

  void listener() {
    if (_controller.value.playerState == PlayerState.ended) {
      _showThankYouDialog();
    }
    
  }

  void _showThankYouDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Reproducción finalizada"),
          content: Text("Gracias por ver el video!"),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _getVideo(),
          _botonSalida()
        ],
      ),
    );
  }


  Widget _getVideo(){
    return YoutubePlayer(
      onPlayerInitialized: (controler){
        _controller = controler;
        _controller.addListener(listener);
      },
      context: context,
      initialVideoId: YoutubePlayer.convertUrlToId(video),
      flags: YoutubePlayerFlags(
        autoPlay: false,
        showVideoProgressIndicator: true,
      ),
      bottomActions: <Widget>[],
    );
  }

  Widget _botonSalida(){
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: RawMaterialButton(
        onPressed: () => Navigator.pop(context),
        child: new Icon(
          Icons.close,
          color: Colors.white,
          size: 35.0,
        ),
        shape: new CircleBorder(),
        elevation: 2.0,
        fillColor: Colors.redAccent,
        padding: const EdgeInsets.all(15.0),
      ),
    );
  }
}