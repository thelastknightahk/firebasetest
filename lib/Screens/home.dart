import 'package:flutter/material.dart';
import 'package:hello_firebase/Screens/book_list.dart';
import 'package:hello_firebase/model/book.dart';
import 'package:hello_firebase/services/auth_service.dart';
import 'package:hello_firebase/services/database_service.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Book>>.value(
      value: DatabaseService().bookData,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Home Page"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async {
                await _authService.signOut();
                print("Logout");
              },
              icon: Icon(Icons.person),
              label: Text("Logout"),
            ),
          ],
        ),
        body:BookList()
      ),
    );
  }
}

