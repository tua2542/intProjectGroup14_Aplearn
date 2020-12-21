import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class ProfileEdit extends StatefulWidget {
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  File _image;
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
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print('Image Path $_image');
      });
    }

    Future uploadPic(_image) async {
      String fileName = basename(_image.path);
      var picId = Uuid().v4();

      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef
          .child("${user.uid}_profilePic_$picId.jpg")
          .putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    }

    Future<void> handleUpdateUserProfile() async {
      final CollectionReference userCollection =
          Firestore.instance.collection('users');
      String mediaUrl = await uploadPic(_image); // Pass your file variable
      // Create/Update firesotre document
      userCollection.document(user.uid).updateData({
        "avatar": mediaUrl,
      });
    }

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
                              child: (_image != null)
                                  ? Image.file(
                                      _image,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.network(
                                      document['avatar'],
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          );
                        }).toList(),
                      )),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.camera_enhance,
                            size: 30.0,
                          ),
                          onPressed: () {
                            getImage();
                          },
                        ),
                      ),
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
                          handleUpdateUserProfile();
                          Flushbar(
                            message: 'Profile Picture Uploaded',
                            icon: Icon(
                              Icons.info_outline,
                              size: 28,
                              color: Colors.blue.shade300,
                            ),
                            leftBarIndicatorColor: Colors.blue.shade300,
                            duration: Duration(seconds: 3),
                          ).show(context);
                        },
                        elevation: 4.0,
                        splashColor: Colors.blueGrey,
                        child: Text(
                          'Submit',
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
