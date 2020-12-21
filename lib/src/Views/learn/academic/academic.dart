import 'package:aplearn_group14/src/Views/learn/academic/subject/thai/thai.dart';
import 'package:aplearn_group14/src/Views/learn/academic/subject/thai/thai_screen.dart';
import 'package:aplearn_group14/src/Views/learn/academic/subject/thai/thai_screen_with_review.dart';
import 'package:flutter/material.dart';

class Academic extends StatefulWidget {
  @override
  _AcademicState createState() => _AcademicState();
}

class _AcademicState extends State<Academic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Learn'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Column(
          children: <Widget>[
            RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Thai',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Thai()));
                }),
            RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Thai Screen',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ThaiScreen()));
                }),
            RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Thai Screen with Review',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ThaiScreenReview()));
                }),
            RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Math',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {}),
          ],
        ),
      ),
    );
  }
}
