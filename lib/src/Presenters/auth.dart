import 'package:aplearn_group14/src/Models/user.dart';
import 'package:aplearn_group14/src/Presenters/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

    
     

class AuthService {


  final FirebaseAuth _auth = FirebaseAuth.instance;

  
  //create user obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null; 
  }

  // auth change user stream 
    Stream<User> get user {
      return _auth.onAuthStateChanged
      // .map((FirebaseUser user) => _userFromFirebaseUser(user));
      .map(_userFromFirebaseUser);
    }

  // sign in anon
  Future signInAnon() async {
    try{
       AuthResult result = await _auth.signInAnonymously();
       FirebaseUser user = result.user;
       return _userFromFirebaseUser(user);
    } catch(e) {
        print(e.toString());
        return null;
    }
  }

// //reset password
Future<void> sendPasswordResetEmail(String email) async {
  try {
   await _auth.sendPasswordResetEmail(email: email);
    } catch(e){
      print(e.toString());
      return null;
    } 
}
  //sign in with email & password
Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;



      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }
  //regsiter with email and password
  Future registerWithEmailAndPassword(String email, String password, String firstname, 
  String lastname, String occupation, String role,String avatar,String birthdate) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      //create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData(email,firstname,lastname,occupation,role,avatar,birthdate);
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch(e) {
        print(e.toString());
        return null;
    }
  }
  
  

}

