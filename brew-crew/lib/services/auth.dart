import 'package:brewcrewapp/models/User.dart';
import 'package:brewcrewapp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService  {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user){
    return user!=null ? User(uid: user.uid) : null;
  }

  Stream<User> get user{
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
  }
  //signin anom
  Future signInAnon() async {
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e)  {
      print(e.toString());
      return null;
    }
}

  //email pass
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e)  {
      print(e.toString());
      return null;
    }
  }

  //reg- email pass
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      await DatabaseService(uid: user.uid).updateUserData('0', 'New Member', 100);  //100 bcz we will map it to color

      return _userFromFirebaseUser(user);
    } catch(e)  {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch(e)  {
      print(e.toString());
      return null;
    }
  }
}