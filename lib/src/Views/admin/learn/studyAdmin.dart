import 'package:aplearn_group14/src/Views/admin/learn/academic/academicAdmin.dart';
import 'package:flutter/material.dart';


class StudyForAdmin extends StatefulWidget {
  @override
  _StudyForAdminState createState() => _StudyForAdminState();
}

class _StudyForAdminState extends State<StudyForAdmin> {
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AcademicForAdmin()));
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