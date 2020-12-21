import 'package:aplearn_group14/src/Presenters/review.dart';
import 'package:aplearn_group14/src/Views/learn/academic/subject/thai/unit_widget/unitOne.dart';
import 'package:aplearn_group14/src/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ThaiScreenReview extends StatefulWidget {
  @override
  _ThaiScreenReviewState createState() => _ThaiScreenReviewState();
}

class _ThaiScreenReviewState extends State<ThaiScreenReview> {
  final maxLines = 5;
  String message = '';
  String helper = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('THAI (Middle school)'),
            ),
            body: Column(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                StreamBuilder<DocumentSnapshot>(
                                    stream: Firestore.instance
                                        .collection('courses')
                                        .document('thai')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      return Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 20.0),
                                            child: RichText(
                                              text: new TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: snapshot.data[
                                                            'courseInformation '] +
                                                        '\n\n',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 20.0),
                                            child: RichText(
                                              text: new TextSpan(
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: snapshot.data['teacherInformation'] + '\n\n',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                Container(
                                  margin: EdgeInsets.all(12),
                                  height: maxLines * 24.0,
                                  child: TextField(
                                      maxLines: maxLines,
                                      decoration: InputDecoration(
                                        hintText: "Enter a message",
                                        fillColor: Colors.grey[300],
                                        filled: true,
                                      ),
                                      onChanged: (val) {
                                        setState(() => message = val);
                                      }),
                                ),
                                SizedBox(height: 20.0),
                                RaisedButton(
                                    color: Colors.pink[400],
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      setState(() => loading = true);
                                      dynamic result = await ReviewProvider()
                                          .updateCommentData(message);
                                      if (result == null) {
                                        setState(() {
                                          loading = false;
                                          helper = 'Your message is sent';
                                        });
                                      }
                                    }),
                                Text(
                                  helper,
                                  style: TextStyle(
                                      color: Colors.pink, fontSize: 14.0),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}

// Column(
//   children: <Widget>[
//     Container(
//       margin: EdgeInsets.all(12),
//       height: maxLines * 24.0,
//       child: TextField(
//           maxLines: maxLines,
//           decoration: InputDecoration(
//             hintText: "Enter a message",
//             fillColor: Colors.grey[300],
//             filled: true,
//           ),
//           onChanged: (val) {
//             setState(() => message = val);
//           }),
//     ),
//   ],
// ),

//                                     SizedBox(height: 20.0),
// RaisedButton(
//     color: Colors.pink[400],
//     child: Text(
//       'Submit',
//       style: TextStyle(color: Colors.white),
//     ),
//     onPressed: () async {}),
