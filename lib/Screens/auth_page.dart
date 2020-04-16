import 'package:flutter/material.dart';
import 'package:hello_firebase/Screens/registerform.dart';

import 'package:hello_firebase/Screens/signin_page.dart';

class AuthenPage extends StatefulWidget {
  @override
  _AuthenPageState createState() => _AuthenPageState();
}

class _AuthenPageState extends State<AuthenPage> {
  bool showSignIn = true;
  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showSignIn ==  true){
      return SignInPage(toggleView: toggleView,);
    }
    else{
      return RegisterForm(toggleView: toggleView,);
    }
     
  }
}