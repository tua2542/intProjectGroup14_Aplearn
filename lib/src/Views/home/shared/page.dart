import 'package:aplearn_group14/src/Views/donation/donation.dart';
import 'package:aplearn_group14/src/Views/learn/study.dart';
import 'package:aplearn_group14/src/Views/profile/profile.dart';
import 'package:aplearn_group14/src/Views/vote/vote.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class HomePageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Column(
              children: <Widget>[
                //Sign In / Register
                RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Learn',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Study()));
                    }),

                RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Vote',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VoteApp()));
                    }),
              ],
            ),
          ),
        );

  }
}

class BusinessPageTwo extends StatefulWidget {
  @override
  _BusinessPageTwoState createState() => _BusinessPageTwoState();
}

class _BusinessPageTwoState extends State<BusinessPageTwo> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  final Firestore _db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Column(
          children: <Widget>[
            //Sign In / Register
            RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Donate',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Donate()));
                }),
          ],
        ),
      ),
    );
  }
}

class SchoolPageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(Icons.school, size: 100);
  }
}

class ContactPageTwo extends StatelessWidget {
  final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'sakdipat3536@gmail.com',
      queryParameters: {'subject': 'Recruitment_with_Aplearn'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Column(
          children: <Widget>[
            RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Work with us',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  launch(_emailLaunchUri.toString());
                }),
                            RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Profile',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                   Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Profile()));
                }),
          ],
        ),
      ),
    );
  }
}
