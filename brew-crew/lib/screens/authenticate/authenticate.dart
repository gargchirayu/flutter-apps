import 'package:brewcrewapp/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:brewcrewapp/screens/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView(){
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn == true){
      return SignIn(toggleView: toggleView);
    } else{
      return SignUp(toggleView: toggleView);
    }
  }
}
