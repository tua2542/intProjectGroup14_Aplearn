import 'package:aplearn_group14/src/Views/learn/academic/academic.dart';
import 'package:flutter/material.dart';


class Study extends StatefulWidget {
  @override
  _StudyState createState() => _StudyState();
}

class _StudyState extends State<Study> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
                  appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Learn'),
            ),
      body : Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Column(
          children: <Widget>[
             RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Academic Learning',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Academic()));
                }),
                RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Alternative Learning',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {}),
          ],
        ),


      ),
    );
  }
}