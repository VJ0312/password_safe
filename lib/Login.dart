import 'package:flutter/material.dart';
import 'dart:async';
import 'AllItems.dart';
import 'Account.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

class Info {
  static var username;
  static var password;
  static var email;
  static var ID;
}

var password = List(100);
var username = List(100);
var EMAIL = List(100);

int code = 1111;
int IDNumber = 1;
int place;
int signInCheck = 0;

bool _canSend = false;
bool _signedIn = false;
bool _autoValidate = false;
bool _autoValidate1 = false;
bool _autoValidate2 = false;

GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
GlobalKey<FormState> _passwordForgot = GlobalKey<FormState>();
GlobalKey<FormState> _invalidUser;
GlobalKey<FormState> _invalidPass;

final p_controller = TextEditingController();
final e_controller = TextEditingController();
final wrongPassUser = SnackBar(
  content: Text("Incorrect password/username"),
  duration: Duration(seconds: 2),
);

class HomeState extends StatefulWidget {
  var s;
  HomeState(this.s);
  homeState createState() => homeState(s);
}

class homeState extends State<HomeState> {
  static const platform = const MethodChannel('sendText');
  var s;
  homeState(this.s);
  void initState() {
    super.initState();
    signInCheck = 0;
    _invalidUser = GlobalKey<FormState>(debugLabel: "invalidUser");
    _invalidPass = GlobalKey<FormState>(debugLabel: "invalidPass");
    if (EMAIL[0] == null) {
      EMAIL[0] = "user@gmail.com";
      username[0] = "user";
      password[0] = "pass";
      accountPass.add(AccountPass());
      print("accountPass length ${accountPass.length}");
    }
  }

  Future<void> checkID(String e, p) async {
    return _checkID(e, p);
  }

  void _checkID(String e, p) {
    print(EMAIL.length);
    for (int i = 0; i <= EMAIL.length - 1; i++) {
      if (e == username[i] || e == EMAIL[i]) {
        if (p == password[i]) {
          _signedIn = true;
          place = i;
          Info.password = p;
          Info.username = username[i];
          Info.email = EMAIL[i];
          Info.ID = place;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AllItems(s)),
          );
          break;
        }
      }
      if (i == EMAIL.length - 1) {
        if (!_signedIn) {
          print("Wrong");
          _key.currentState.showSnackBar(wrongPassUser);
        }
      }
    }
  }

  Future<void> sendResetEmail(String address) async {
    try {
      int _num;
      for (int i = 0; i <= EMAIL.length - 1; i++) {
        if (address == EMAIL[i]) {
          _num = i;
          print("Found");
          break;
        }
        if (i == EMAIL.length) {
          if (_num != i) {
            print("Not found");
          }
        }
        final Email email = Email(
          subject: "Password Reset Email",
          body: "Password: ${Info.password}, "
              "Username: ${Info.username}",
          recipients: [address],
          attachmentPaths: null,
          isHTML: false,
        );
        await FlutterEmailSender.send(email);
      }
    } catch (e) {
      throw 'Error message: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        key: _key,
        body: Container(
          child: Column(
            children: [
              Logo(context),
              PasswordBox(),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                  child: Text("Enter"),
                  color: Colors.redAccent,
                  onPressed: () {
                    _invalidPass.currentState.validate();
                    _invalidUser.currentState.validate();
                    if (e_controller.text.toString() != "") {
                      if (p_controller.text.toString() != "") {
                        checkID(e_controller.text.toString(),
                            p_controller.text.toString());
                      }
                    }
                  }),
              RaisedButton(
                  color: Colors.redAccent,
                  child: Text("Forgot password?"),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                              child: AlertDialog(
                                  title: Text(
                                    "Enter your email",
                                  ),
                                  content: (Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              4,
                                      child: Form(
                                          autovalidate: _autoValidate,
                                          key: _passwordForgot,
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                controller: _controller,
                                                validator: (value) {
                                                  if (value.isEmpty ||
                                                      !value.contains("@") ||
                                                      !value.contains(".com")) {
                                                    _canSend = false;
                                                    return "This field is required";
                                                  } else {
                                                    _canSend = true;
                                                    return null;
                                                  }
                                                },
                                              ),
                                              SizedBox(
                                                height: 40,
                                              ),
                                              MaterialButton(
                                                color: Colors.redAccent,
                                                child: Text(
                                                  "Send",
                                                ),
                                                onPressed: () {
                                                  if (_passwordForgot
                                                      .currentState
                                                      .validate()) {
                                                    _passwordForgot.currentState
                                                        .save();
                                                  } else {
                                                    setState(() {
                                                      _autoValidate = true;
                                                    });
                                                  }
                                                  if (_canSend) {
                                                    sendResetEmail(_controller
                                                        .text
                                                        .toString());
                                                    Navigator.pop(context);
                                                  }
                                                },
                                              )
                                            ],
                                          ))))));
                        });
                  }),
              RaisedButton(
                child: Text("Sign up"),
                color: Colors.redAccent,
                onPressed: () {
                  setState(() {
                    makeID(context);
                  });
                },
              )
            ],
          ),
        ));
  }
}

Widget Logo(context) {
  return Column(
    children: [
      SizedBox(
        height: 20,
      ),
      Container(
        height: 170,
        child: Image(image: AssetImage('images/keyIcon.png')),
      ),
      Text(
        "OnePass",
        style: TextStyle(
          fontSize: 40,
        ),
      ),
      Text(
        "One password forever",
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      SizedBox(
        height: 20,
      ),
    ],
  );
}

Widget PasswordBox() {
  var s;
  return Column(
    children: [
      Form(
        key: _invalidUser,
        autovalidate: _autoValidate1,
        child: TextFormField(
          controller: e_controller,
          validator: (value) {
            if (value.isEmpty) {
              signInCheck++;
              return "This field cannot be left empty";
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
              hintText: "Enter username / email",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Form(
        key: _invalidPass,
        autovalidate: _autoValidate2,
        child: TextFormField(
          controller: p_controller,
          validator: (_value) {
            if (_value.isEmpty) {
              signInCheck++;
              return "This field cannot be left empty";
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
              hintText: "Enter password",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
      ),
    ],
  );
}

void makeID(context) async {
  return makeIDPopUp(context);
}

Future<void> makeIDPopUp(context) async {
  var s;
  final _usernameC = TextEditingController();
  final _passwordC = TextEditingController();
  final EMAILC = TextEditingController();
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Container(
          height: MediaQuery.of(context).size.height / 2,
          child: AlertDialog(
              title: Column(
                children: [
                  Container(
                    child: Text(
                      "OnePass",
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                  Text(
                      "Enter your email address, a username, and a password to sign up"
                  ),
                ],
              ),
              content: Builder(builder: (context) {
                return Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Column(
                      children: [
                        Container(
                          child: TextFormField(
                            controller: EMAILC,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: "Enter your email",
                            ),
                          ),
                        ),
                        // ),
                        SizedBox(height: 20),
                        Container(
                          child: TextFormField(
                            controller: _usernameC,
                            decoration: InputDecoration(
                              hintText: "Enter a username",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: TextFormField(
                            controller: _passwordC,
                            decoration: InputDecoration(
                              hintText: "Enter a password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        FlatButton(
                          child: Text('Save'),
                          color: Colors.redAccent,
                          onPressed: () {
                            accountPass.add(AccountPass());
                            print("IDNumber $IDNumber");
                            EMAIL[IDNumber] = EMAILC.text.toString();
                            username[IDNumber] = _usernameC.text.toString();
                            password[IDNumber] = _passwordC.text.toString();
                            IDNumber++;
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ));
              })));
    },
  );
}
