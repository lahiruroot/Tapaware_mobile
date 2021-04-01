import 'package:flutter/material.dart';
import 'package:tap_aware/data.dart';
import 'package:tap_aware/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final email = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  signIn() {
    var defoult = Firebase.initializeApp();
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.text, password: password.text)
        .then((value) {
      if (value.user.uid != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Data()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  String _email;
  String _pass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Image.asset(
              "images/titile.png",
              height: 150.0,
              width: 151.0,
            )),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Align(
                      alignment: Alignment(0, -0.8),
                      child: Image.asset(
                        "images/login.png",
                        height: 250,
                        width: 300,
                      ), //main image
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment(0, -0.8),
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: TextFormField(
                      maxLength: 25,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          hintText: "Email"),
                      controller: email,
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Email cannot be empty';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        _email = val;
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: TextFormField(
                      maxLength: 15,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          hintText: "Password"),
                      controller: password,
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Password cannot be empty';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        _pass = val;
                      },
                    ),
                  ),
                  //Buttton
                  Container(
                    height: 50.0,
                    // margin: EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          signIn();
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) => data()));
                        }
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          colors: [Color(0xff099A41), Color(0xff77f745)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        )),
                        // borderRadius: BorderRadius.circular(26.0)),
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: 200.0, minHeight: 80.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'If you are not a member ?',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                    child: Text("SingUp",
                        style: TextStyle(fontSize: 18, color: Colors.green)),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
