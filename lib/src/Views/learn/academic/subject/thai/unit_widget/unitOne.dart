import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:aplearn_group14/src/Models/video_info.dart';
import 'package:aplearn_group14/src/Presenters/video_provider.dart';
import 'package:aplearn_group14/src/Presenters/encoding_provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:aplearn_group14/src/Views/video_player/player.dart';

class UnitOneWidget extends StatefulWidget {
  @override
  _UnitOneWidgetState createState() => _UnitOneWidgetState();
}

class _UnitOneWidgetState extends State<UnitOneWidget> {
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
  
  @override
  Widget build(BuildContext context) {
   return _getListView();
  }
  
  final ScrollController _scrollController = ScrollController();
  
  Widget _getListView() {
    return ListView.builder(
        controller: _scrollController,
        shrinkWrap: true,
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
                                  Container(),
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
 
}
