import 'package:aplearn_group14/src/Presenters/auth.dart';
import 'package:aplearn_group14/src/Views/admin/admin.dart';
import 'package:aplearn_group14/src/shared/constants.dart';
import 'package:aplearn_group14/src/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class SignInForAdmin extends StatefulWidget {
  @override
  _SignInForAdminState createState() => _SignInForAdminState();
}

class _SignInForAdminState extends State<SignInForAdmin> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Sign in to Aplearn for admin'),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'email'),
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      obscureText: true,
                      decoration:
                          textInputDecoration.copyWith(hintText: 'password'),
                      validator: (val) => val.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error =
                                    'Could not sign in with those credentials';
                              });
                            } else {
                              FirebaseAuth.instance.currentUser().then((user) {
                                Firestore.instance
                                    .collection('users')
                                    .where('uid', isEqualTo: user.uid)
                                    .getDocuments()
                                    .then((docs) {
                                  if (docs.documents[0].exists) {
                                    if (docs.documents[0].data['role'] ==
                                        'admin') {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AdminPage()),
                                          (route) => false);
                                    }
                                  }
                                });
                              });
                            }
                          }
                        }),
                    FlatButton(
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (BuildContext context) {
                              return Scaffold(
                                backgroundColor: Colors.brown[100],
                                appBar: AppBar(
                                  title: Text('Reset Password'),
                                  backgroundColor: Colors.brown[400],
                                  elevation: 0.0,
                                ),
                                body: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 50.0),
                                  child: Form(
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(height: 20.0),
                                        TextFormField(
                                            decoration: textInputDecoration
                                                .copyWith(hintText: 'Email'),
                                            validator: (val) => val.isEmpty
                                                ? 'Enter an email'
                                                : null,
                                            onChanged: (val) {
                                              setState(() => email = val);
                                            }),
                                        SizedBox(height: 20.0),
                                        FlatButton(
                                            color: Colors.pink[400],
                                            child: Text(
                                              'reset',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () async {
                                              _auth.sendPasswordResetEmail(
                                                  email);
                                              if (email != null) {
                                                Flushbar(
                                                  title: 'Reset Password',
                                                  message:
                                                      'We send the detail to $email successfully',
                                                  icon: Icon(
                                                    Icons.info_outline,
                                                    size: 28,
                                                    color: Colors.blue.shade300,
                                                  ),
                                                  leftBarIndicatorColor:
                                                      Colors.blue.shade300,
                                                  duration:
                                                      Duration(seconds: 3),
                                                ).show(context);
                                              }
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          );
                        }),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
