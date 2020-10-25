import 'BottomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:password_safe/Login.dart';
import 'Passwords.dart';
import 'notes.dart';
import 'CreditCard.dart';

class AccountPass {
  List<Password> pass = [];
  List<Note> noteList = [];
  List<CardInfo> cardList = [];
}

List<AccountPass> accountPass = [];
GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

String _passwordText;
String _usernameText;

class Account extends StatefulWidget {
  var s;
  Account(this.s);
  account createState() => account(s);
}

class account extends State<Account> {
  var s;
  account(this.s);
  void initState() {
    super.initState();
    _passwordText = Info.password;
    _usernameText = Info.username;
  }
  Future<void> deleteAccountDialog() async {
    final check1Controller = TextEditingController();
    final check2Controller = TextEditingController();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Delete Account"),
            content: Column(
              children: [
                TextField(
                  controller: check1Controller,
                  decoration: InputDecoration(hintText: "Enter password"),
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Enter password Again"),
                  controller: check2Controller,
                  onSubmitted: (value) {
                    check2Controller.text.toString();
                  },
                ),
                MaterialButton(
                  color: Colors.redAccent,
                  child: Text('Delete Account'),
                  onPressed: () {
                    setState(() {
                      if (check1Controller.text.toString() ==
                          check2Controller.text.toString()) {
                        if (check2Controller.text.toString() != "" &&
                            check1Controller.text.toString() != "") {
                          deleteAccount();
                        }
                      }
                    });
                  },
                )
              ],
            ),
          );
        });
  }

  void deleteAccount() {
    setState(() {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomeState(s),
          ));
      password[place] = "";
      username[place] = "";
      EMAIL[place] = "";
      Info.email = "";
      Info.password = "";
      Info.username = "";
    });
  }

  Future <void> changePassword() async{
    final _c1 = TextEditingController();
    final _c2 = TextEditingController();
    final _c3 = TextEditingController();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
            return AlertDialog(
              title: Text( "Change Password"),
              content:
              Builder(
                builder: (context) {
                  return Container(
                     height: MediaQuery.of(context).size.height / 2,
                      child: Column(
                    children: [
                      Text(
                          "Enter current Password"
                      ),
                      TextField(
                        controller: _c1,
                      ),
                      Text(
                          "Enter new Password"
                      ),
                      TextField(
                        controller: _c2,
                      ),
                      Text(
                          "Re-enter new Password"
                      ),
                      TextField(
                        controller: _c3,
                      ),
                      MaterialButton(
                        color: Colors.redAccent,
                        child: Text(
                            "Save"
                        ),
                        onPressed: () {
                          int _place = 0;
                          setState(() {
                            Navigator.pop(context);
                            for (int i = 0; i<=password.length - 1; i++) {
                              if (password[i] == _c1.text.toString()) {
                                _place = i;
                                break;
                              }
                            }
                            _passwordText = _c3.text.toString();
                            password[_place] = _c3.text.toString();
                          });
                        },
                      )
                    ],
                  ));
                },
              )
            );
        });
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      floatingActionButton: FloatingActionButton(
        heroTag: "1",
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {});
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBarClass(s).BottomAppBarWidget(context),
      body: Builder(
        builder: (context) {
          return Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Text("Account Settings",
                    style: TextStyle(
                      fontSize: 40,
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 34),
                    child: Text(
                      "Details",
                      style: TextStyle(
                        fontSize: 32,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Username: $_usernameText",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "password: $_passwordText",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Email: ${Info.email}",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 34),
                    child: Text(
                      "Options",
                      style: TextStyle(
                        fontSize: 32,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                    onPressed: () {
                      changePassword();
                    },
                    color: Colors.redAccent,
                    child: Text(
                      "Change password/Email",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  color: Colors.redAccent,
                  child: Text(
                    "Log out",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  onPressed: () {
                    print(username[0]);
                    print(password[0]);
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => HomeState(s)
                    ));
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  color: Colors.redAccent,
                  child: Text("Delete Account",
                      style: TextStyle(
                        fontSize: 24,
                      )),
                  onPressed: () {
                    deleteAccountDialog();
                  },
                ),
              ],
            ),
          );
        },
      )

    );
  }
}
