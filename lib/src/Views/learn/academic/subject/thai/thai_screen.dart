import 'package:aplearn_group14/src/Views/learn/academic/subject/thai/unit_widget/unitOne.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ThaiScreen extends StatefulWidget {
  @override
  _ThaiScreenState createState() => _ThaiScreenState();
}

class _ThaiScreenState extends State<ThaiScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('courses')
            .document('thai')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('Loading...');
            default:
              return Scaffold(
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
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 20.0),
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
                                          vertical: 10.0, horizontal: 20.0),
                                      child: Column(
                                        children: <Widget>[],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30.0),
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(height: 20.0),
                                          ExpansionTile(
                                            title: Text(
                                              "Unit 1",
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            children: <Widget>[
                                              UnitOneWidget()
                                            ],

                                          ),
                                          ExpansionTile(
                                            title: Text(
                                              "Unit 2",
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            children: <Widget>[
                                              ListTile(
                                                title: Text('data'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 20.0),
                                      child: RichText(
                                        text: new TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: 'Instructor' + '\n\n',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ClipOval(
                                      child: SizedBox(
                                        width: 60.0,
                                        height: 60.0,
                                        child: Image.network(
                                          snapshot.data['teacher_avatar'],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 20.0),
                                      child: RichText(
                                        text: new TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: snapshot.data['firstname'] +
                                                  ' ' +
                                                  snapshot.data['lastname'] +
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
                                          vertical: 10.0, horizontal: 20.0),
                                      child: RichText(
                                        text: new TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: snapshot.data[
                                                      'teacherInformation'] +
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
        });
  }
}
