import 'package:aplearn_group14/src/Views/profile/profile_edit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('users')
            .where("uid", isEqualTo: user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('Loading...');
            default:
              return Scaffold(
                appBar: AppBar(
                  title: Text("Profile"),
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      Container(
                          child: Column(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                          return ClipOval(
                            child: SizedBox(
                              width: 120.0,
                              height: 120.0,
                              child: Image.network(
                                document['avatar'],
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        }).toList(),
                      )),
                      SizedBox(height: 20.0),
                      Container(
                          child: Column(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                          return new Text(
                              "Name: " +
                                  document['firstname'] +
                                  " " +
                                  document['lastname'],
                              textScaleFactor: 1.2);
                        }).toList(),
                      )),
                      SizedBox(height: 20.0),
                      Container(
                          child: Column(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                          return new Text("Email: " + document['email'],
                              textScaleFactor: 1.2);
                        }).toList(),
                      )),
                      SizedBox(height: 20.0),
                      Container(
                          child: Column(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                          return new Text(
                              "Occupation: " + document['occupation'],
                              textScaleFactor: 1.2);
                        }).toList(),
                      )),
                      SizedBox(height: 20.0),
                      Container(
                          child: Column(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                          return new Text(
                              "Birth Date: " + document['birthdate'],
                              textScaleFactor: 1.2);
                        }).toList(),
                      )),
                      SizedBox(height: 20.0),
                      RaisedButton(
                        color: Color(0xff476cfb),
                        onPressed: () {
                           Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ProfileEdit()));
                        },
                        elevation: 4.0,
                        splashColor: Colors.blueGrey,
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                ),
              );
          }
        });
  }
}
