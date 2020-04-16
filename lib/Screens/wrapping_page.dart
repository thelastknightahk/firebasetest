import 'package:flutter/material.dart';
import 'package:hello_firebase/Screens/auth_page.dart';
import 'package:hello_firebase/Screens/home.dart';
import 'package:hello_firebase/model/user.dart';
import 'package:provider/provider.dart';


class WrappingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     final user = Provider.of<User>(context);
     print(user);
     if(user == null ){
       return AuthenPage();
     }
     else{
       return Home();
     }
    
  }
}