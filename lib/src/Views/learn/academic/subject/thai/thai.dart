import 'package:aplearn_group14/src/Models/video_info.dart';
import 'package:aplearn_group14/src/Presenters/encoding_provider.dart';
import 'package:aplearn_group14/src/Presenters/video_provider.dart';
import 'package:aplearn_group14/src/Views/video_player/player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:timeago/timeago.dart' as timeago;

class Thai extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thai',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Thai Lesson'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final thumbWidth = 100;
  final thumbHeight = 150;
  List<VideoInfo> _videos = <VideoInfo>[];
  bool _canceled = false;
  int _videoDuration = 0;

  @override
  void initState() {
    FirebaseProvider.listenToVideos((newVideos) {
      setState(() {
        _videos = newVideos;
      });
    });

    EncodingProvider.enableStatisticsCallback((int time,
        int size,
        double bitrate,
        double speed,
        int videoFrameNumber,
        double videoQuality,
        double videoFps) {
      if (_canceled) return;
    });

    super.initState();
  }

  Widget _getListView()  {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _videos.length,
        itemBuilder: (BuildContext context, int index) {
          final video = _videos[index];
          return StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .collection('courses')
                  .document('thai')
                  .collection('unit')
                  .document('unit1')
                  .collection('videos')
                  .document()
                  .snapshots(),
              builder: (context, snapshot) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ChewiePlayer(
                            video: video,
                          );
                        },
                      ),
                    );
                  },
                  child: Card(
                    child: new Container(
                      padding: new EdgeInsets.all(10.0),
                      child: Stack(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    // width: thumbWidth.toDouble(),
                                    // height: thumbHeight.toDouble(),
                                    // child: Center(
                                    //     child: CircularProgressIndicator()),
                                  ),
                                  // ClipRRect(
                                  //   borderRadius:
                                  //       new BorderRadius.circular(8.0),
                                  //   child: FadeInImage.memoryNetwork(
                                  //     placeholder: kTransparentImage,
                                  //     image: video.thumbUrl,
                                  //   ),
                                  // ),
                                ],
                              ),
                              Expanded(
                                child: Container(
                                  margin: new EdgeInsets.only(left: 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Text("${video.videoName}"),
                                      Container(
                                        margin: new EdgeInsets.only(top: 12.0),
                                        child: Text(
                                            'Uploaded ${timeago.format(new DateTime.fromMillisecondsSinceEpoch(video.uploadedAt))}'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: _getListView()),
    );
  }
}
