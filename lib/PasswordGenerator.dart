import 'dart:math';
import 'package:flutter/material.dart';
import 'BottomAppBar.dart';
import 'Passwords.dart';

const DEFAULT = "";

class PasswordGenerator extends StatefulWidget {
  var s;
  PasswordGenerator(this.s);
  password_generator createState() => password_generator(s);
}

enum passwordType {
  l,
  ls,
  ln,
  lns,
}

class password_generator extends State<PasswordGenerator> {
  var s;
  password_generator(this.s);
  double passwordLegnth = 6;
  var _passwordTypeGroupValue = passwordType.l;
  bool isNewPassword = false;
  String newPassword = "";
  final newPasswordController = TextEditingController();

  void initState() {
    super.initState();
    isNewPassword = false;
  }

  void makePassword(var _passType, int length) {
    var random = new Random();
    List<String> allLetters = [
      "a",
      "b",
      "c",
      "d",
      "e",
      "f",
      "g",
      "h",
      "i",
      'j',
      'k',
      'l',
      'm',
      'n',
      'o',
      'p',
      'q',
      'r',
      's',
      't',
      'u',
      'v',
      'w',
      'x',
      'y',
      "z",
      "A",
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      "O",
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z'
    ];
    List<dynamic> lettersAndNumbers = [
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      "7",
      "8",
      "9",
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      "7",
      "8",
      "9",
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      "7",
      "8",
      "9",
      "a",
      "b",
      "c",
      "d",
      "e",
      "f",
      "g",
      "h",
      "i",
      'j',
      'k',
      'l',
      'm',
      'n',
      'o',
      'p',
      'q',
      'r',
      's',
      't',
      'u',
      'v',
      'w',
      'x',
      'y',
      "z",
      "A",
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      "O",
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z',
    ];
    List<dynamic> lettersNumbersAndSymbols = [
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      "7",
      "8",
      "9",
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      "7",
      "8",
      "9",
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      "7",
      "8",
      "9",
      "a",
      "b",
      "c",
      "d",
      "e",
      "f",
      "g",
      "h",
      "i",
      'j',
      'k',
      'l',
      'm',
      'n',
      'o',
      'p',
      'q',
      'r',
      's',
      't',
      'u',
      'v',
      'w',
      'x',
      'y',
      "z",
      "A",
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      "O",
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z',
      "!",
      "@",
      "#",
      '%',
      "^",
      "&",
      "*"
          "@",
      "#",
      '%',
      "^",
      "&",
      "*"
          "@",
      "#",
      '%',
      "^",
      "&",
      "*"
          "@",
      "#",
      '%',
      "^",
      "&",
      "*"
    ];
    List <dynamic> lettersandsymbols = [
      "a",
      "b",
      "c",
      "d",
      "e",
      "f",
      "g",
      "h",
      "i",
      'j',
      'k',
      'l',
      'm',
      'n',
      'o',
      'p',
      'q',
      'r',
      's',
      't',
      'u',
      'v',
      'w',
      'x',
      'y',
      "z",
      "A",
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      "O",
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z',
      "!",
      "@",
      "#",
      '%',
      "^",
      "&",
      "*"
          "@",
      "#",
      '%',
      "^",
      "&",
      "*"
          "@",
      "#",
      '%',
      "^",
      "&",
      "*"
          "@",
      "#",
      '%',
      "^",
      "&",
      "*"
    ];

    var passwordList = new List(length + 1);
    isNewPassword = true;
    switch (_passType) {
      case passwordType.l:
        for (int i = 0; i <= passwordLegnth - 1; i++) {
          passwordList[i] = allLetters[random.nextInt(allLetters.length - 1)];
          newPassword += passwordList[i];
        }
        break;
      case passwordType.ln:
        for (int i = 0; i <= passwordLegnth - 1; i++) {
          passwordList[i] =
              lettersAndNumbers[random.nextInt(lettersAndNumbers.length - 1)];
          newPassword += passwordList[i];
        }
        break;
      case passwordType.ls:
        for (int i = 0; i <= passwordLegnth - 1; i++) {
          passwordList[i] =
          lettersandsymbols[random.nextInt(lettersandsymbols.length - 1)];
          newPassword += passwordList[i];
        }
        break;
      case passwordType.lns:
        for (int i = 0; i <= passwordLegnth - 1; i++) {
          passwordList[i] =
          lettersNumbersAndSymbols[random.nextInt(lettersNumbersAndSymbols.length - 1)];
          newPassword += passwordList[i];
        }
        break;
    }
    setState(() {
      newPasswordController.text = newPassword;
    });
  }

  void savePassword() {
    insidePage(s).addPasswordItem(context, newPassword, false);
  }

  Widget RadioButton(passwordType pass) {
    return Row(
      children: [
        Radio(
          activeColor: Colors.redAccent,
          value: pass,
          groupValue: _passwordTypeGroupValue,
          onChanged: (value) {
            setState(() {
              _passwordTypeGroupValue = value;
            });
          },
        ),
        Text(pass == passwordType.l
            ? "Letters"
            : pass == passwordType.ln
                ? "Letters and numbers"
                : pass == passwordType.ls
                    ? "Letters and symbols"
                    : "Letters, symbols, and numbers")
      ],
    );
  }

  Widget passwordSlider() {
    return Slider(
      //inactiveColor: Colors.redAccent,
      activeColor: Colors.redAccent,
      divisions: 9,
      value: passwordLegnth,
      min: 6,
      max: 15,
      onChanged: (value) {
        setState(() {
          passwordLegnth = value;
        });
      },
    );
  }

  Widget passwordBox() {
    return TextField(
      decoration: InputDecoration(border: OutlineInputBorder()),
      controller: newPasswordController,
      readOnly: true,
    );
  }

  Widget build(BuildContext context) {
    setState(() {
      if (!isNewPassword) {
        newPasswordController.text = "Your password appears here";
      } else {
        newPasswordController.text = newPassword;
      }
    });
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: "1",
          backgroundColor: Colors.redAccent,
          child: Icon(Icons.add),
          onPressed: () {
            insidePage(s).addPasswordItem(context, newPassword, true);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBarClass(s).BottomAppBarWidget(context),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Text(
                  "Generator", style: TextStyle(
                  fontSize: 50,
                )
                ),
                Text("${passwordLegnth.toInt()} characters",
                    style: TextStyle(
                      fontSize: 20,
                    )),
                passwordSlider(),
                RadioButton(passwordType.l),
                RadioButton(passwordType.ln),
                RadioButton(passwordType.ls),
                RadioButton(passwordType.lns),
                SizedBox(
                  height: 20,
                ),
                passwordBox(),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  color: Colors.redAccent,
                  child: Text("Enter"),
                  onPressed: () {
                    newPassword = "";
                    makePassword(
                        _passwordTypeGroupValue, passwordLegnth.toInt());
                  },
                ),
                MaterialButton(
                  color: Colors.redAccent,
                  child: Text("Save"),
                  onPressed: () {
                    savePassword();
                  },
                ),
              ],
            ),
          ),
        );
  }
}
