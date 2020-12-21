import 'package:aplearn_group14/src/Views/admin/learn/academic/subject/thai/thaiAdmin.dart';
import 'package:flutter/material.dart';


class AcademicForAdmin extends StatefulWidget {
  @override
  _AcademicForAdminState createState() => _AcademicForAdminState();
}

class _AcademicForAdminState extends State<AcademicForAdmin> {
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
                  'Thai',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ThaiForAdmin()));

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