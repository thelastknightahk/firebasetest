import 'package:flutter/material.dart';
import 'package:hello_firebase/Screens/phone_authpage.dart';
import 'package:hello_firebase/services/auth_service.dart';
import 'package:hello_firebase/sharedfile/constant_data.dart';
import 'package:hello_firebase/sharedfile/loading.dart';

class RegisterForm extends StatefulWidget {
  final Function toggleView;

  const RegisterForm({Key key, this.toggleView}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
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
              backgroundColor: Colors.brown[400],
              title: Text("Sign Up Form"),
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: () async {
                    widget.toggleView();
                    print("Sign In");
                  },
                  label: Text("Sign In"),
                  icon: Icon(Icons.person),
                )
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (val) => val.isEmpty ? 'Enter Email ' : null,
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
                            val.length < 6 ? 'Enter Password  +6' : null,
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
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _loading = true;
                            });
                            dynamic result = await _authService
                                .signUpWithEmailAndPass(_email, _pass);
                            if (result == null) {
                              setState(() {
                                _loading = false;
                                _error =
                                    'Please Supply a valid email and password ';
                              });
                            }
                            print(_email);
                            print(_pass);
                          }
                        },
                        child: Text("Sign Up"),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        _error,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.0,
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PhoneAuth()),
                          );
                        },
                        child: Text("Go to Phone Authentication"),
                      )
                    ],
                  ),
                )),
          );
  }
}
