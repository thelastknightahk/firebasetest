import 'package:flutter/material.dart';
import 'package:hello_firebase/Screens/wrapping_page.dart';
import 'package:hello_firebase/services/auth_service.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
        value: AuthService().userdata,
        
          child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
           
          primarySwatch: Colors.blue,
        ),
        home:WrappingPage()
      ),
    );
  }
}
 