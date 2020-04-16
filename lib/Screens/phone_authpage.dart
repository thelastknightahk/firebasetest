import 'package:flutter/material.dart';
import 'package:hello_firebase/services/auth_service.dart';

class PhoneAuth extends StatefulWidget {
  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  final _auth = AuthService();
  final _key = GlobalKey<FormState>();
  String _phone = "";
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
          child: Form(
            key: _key,
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (v) =>
                      v.isEmpty ? 'Enter Valid Phone Number ' : null,
                  onChanged: (val) => _phone = val,
                  decoration: InputDecoration(hintText: 'Enter Phone Number'),
                ),
                RaisedButton(
                  onPressed: () {
                     _auth.signInWithPhoneNumber(_phone, context);
                    print("Get OTP");
                  },
                  child: Text("Get OTP"),
                ),
              ],
            ),
          )),
    );
  }
}
