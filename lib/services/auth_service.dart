import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello_firebase/Screens/home.dart';
import 'package:hello_firebase/model/user.dart';
import 'package:hello_firebase/services/database_service.dart';

class AuthService {
  String _codeSent = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _firebaseUser(FirebaseUser user) {
    return user != null ? User(userid: user.uid) : null;
  }

  Stream<User> get userdata {
    return _auth.onAuthStateChanged.map(_firebaseUser);
  }

  //Sign In
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _firebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future signUpWithEmailAndPass(String email, String pass) async {
    try {
      AuthResult _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      FirebaseUser user = _authResult.user;
      //create a new document
      await DatabaseService(uid: user.uid)
          .upLoadUserData("Aung Htet", "Success With Idea", 9);
      return _firebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPass(String email, String pass) async {
    try {
      AuthResult result =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user = result.user;
      return _firebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign In with Phone Number
  Future signInWithPhoneNumber(String phone, BuildContext _context) async {
    try {
      String phoneNumber = "+959" + phone;
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: Duration(seconds: 60),
          verificationCompleted: (AuthCredential crendential) async {
            AuthResult result = await _auth.signInWithCredential(crendential);
            FirebaseUser user = result.user;
            print(user.uid);
          },
          verificationFailed: (e) {
            print(e.message + "hello");
          },
          codeSent: (String verificationid, [int forceResendingToken]) {
            showDialog(
                context: _context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Give The OTP"),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          onChanged: (val) => _codeSent = val,
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () async {
                          AuthCredential credential =
                              PhoneAuthProvider.getCredential(
                                  verificationId: verificationid,
                                  smsCode: _codeSent);
                          AuthResult result =
                              await _auth.signInWithCredential(credential);
                          FirebaseUser user = result.user;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );
                          print("AuthService Phone Number is Successful" +
                              user.uid);
                        },
                        child: Text("Confirm"),
                        textColor: Colors.white,
                        color: Colors.blue,
                      )
                    ],
                  );
                });
          },
          codeAutoRetrievalTimeout: null);
    } catch (e) {
      print(e.toString() + "usererr");
      return null;
    }
  }

  //Sign Out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
