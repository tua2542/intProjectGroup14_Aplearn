import 'package:aplearn_group14/src/Presenters/comment.dart';
import 'package:aplearn_group14/src/Views/vote/vote_widget/vote_widget.dart';
import 'package:aplearn_group14/src/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VoteApp extends StatefulWidget {
  @override
  @override
  _VoteAppState createState() => _VoteAppState();
}

// _buildBody(context),
class _VoteAppState extends State<VoteApp> {
  final maxLines = 5;
  FirebaseUser user;
  String message = '';
  String helper = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(centerTitle: true, title: Text('Voting Panel')),
            body: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                StreamBuilder<DocumentSnapshot>(
                    stream: Firestore.instance
                        .collection('voteCourseTitle')
                        .document('title')
                        .snapshots(),
                    builder: (context, snapshot) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Center(
                          child: RichText(
                            text: new TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: snapshot.data['question'] + '\n',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                SizedBox(height: 10.0),
                Flexible(
                  child: VoteWidget(),
                ),
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
                      dynamic result =
                          await CommentProvider().updateCommentData(message);
                      if (result == null) {
                        setState(() {
                          loading = false;
                          helper = 'Your message is sent';
                        });
                      }
                    }
                    ),
                Text(
                  helper,
                  style: TextStyle(color: Colors.pink, fontSize: 14.0),
                ),
                SizedBox(height: 90.0),
              ],
            ),
          );
  }
}
