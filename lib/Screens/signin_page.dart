import 'package:flutter/material.dart';
import 'package:hello_firebase/services/auth_service.dart';
import 'package:hello_firebase/sharedfile/constant_data.dart';
import 'package:hello_firebase/sharedfile/loading.dart';

class SignInPage extends StatefulWidget {
  final Function toggleView;

  const SignInPage({Key key, this.toggleView}) : super(key: key);
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  AuthService _authService = AuthService();
  final _key = GlobalKey<FormState>();
  bool _loading = false;
  String _email = "";
  String _pass = "";
  String _error = "";
  @override
  Widget build(BuildContext context) {
    return _loading
        ? LoadingPage()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.brown[40],
              title: Text("Sign In Form"),
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: () async {
                    widget.toggleView();
                    print("Register");
                  },
                  label: Text("Register"),
                  icon: Icon(Icons.person),
                )
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _key,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (val) =>
                            val.isEmpty ? 'Enter Your Email' : null,
                        onChanged: (val) {
                          setState(() {
                            _email = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        validator: (val) =>
                            val.isEmpty ? 'Enter correct password' : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() {
                            _pass = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                        onPressed: () async {
                          if (_key.currentState.validate()) {
                            setState(() {
                              _loading = true;
                            });
                            dynamic result = await _authService
                                .signInWithEmailAndPass(_email, _pass);
                            if (result == null) {
                              setState(() {
                                _loading = false;
                                _error =
                                    "Please Supply a valid email and password";
                              });
                            } else {
                              print("Sign In Successfully");
                            }
                          }
                        },
                        child: Text("Sign In"),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        _error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      )
                    ],
                  ),
                )),
          );
  }
}
