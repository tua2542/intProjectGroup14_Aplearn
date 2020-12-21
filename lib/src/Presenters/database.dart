import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:lxnavigator/src/models/user.dart';

class DatabaseService{

   final String uid;


  DatabaseService({this.uid });

  // collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future updateUserData(String email, String firstname, 
  String lastname, String occupation, String role , String avatar, String birthdate) async {
     return await userCollection.document(uid).setData({
       'uid' : uid,
       'email': email,
       'firstname': firstname,
       'lastname': lastname,
       'occupation': occupation,
       'role' : role,
       'avatar' : avatar,
       'birthdate': birthdate
       

     });
   }
 }


