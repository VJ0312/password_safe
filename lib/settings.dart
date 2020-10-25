import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Passwords.dart';
import 'notes.dart';
import 'CreditCard.dart';
import 'package:flutter/material.dart';
import 'BottomAppBar.dart';

class Settings extends StatefulWidget {
  var s;
  Settings(this.s);
  @override
  settings createState() => settings(s);
}

class settings extends State<Settings> {
  var s;
  settings(this.s);

  void clearPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Widget fontButton(String _fontText, _font) {
    bool selected = false;
    return Row(
      children: [
        SizedBox(width: 120),
        Container(
          alignment: Alignment.center,
          child: FlatButton(
            hoverColor: Colors.white70,
            child: Text(
              _fontText,
              style: TextStyle(
                fontSize: 20,
                fontFamily: _font,
              ),
            ),
            onPressed: () {
              setState(() {
                setFontType(_fontText);
              });
            },
          ),
        ),
        Container(
          child: selected? Icon(
            Icons.check,
          ): null,
        )
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
                alignment: Alignment.topCenter,
                child: Text("Settings",
                    style: TextStyle(
                      fontSize: 50,
                    ))),
            Text(
              "Display",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Row(
              children: [
                Text(
                  "Dark Theme",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Switch(
                    value: darkTheme,
                    onChanged: (value) {
                      setTheme();
                    })
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text("Font Style",
                  style: TextStyle(
                    fontSize: 20,
                  )),
            ),
            fontButton("Architect", "ArchitectsDaughter"),
            fontButton("DancingScript", "DancingScript"),
            fontButton("IndieFlower", "IndieFlower"),
            fontButton("Oswald", "Oswald"),
            fontButton("Poppins", "Poppins-Medium"),
            fontButton("Sansita", "SansitaSwashed"),
            fontButton("Staatliches", "Staatliches"),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              child: Text("Other",
                  style: TextStyle(
                    fontSize: 30,
                  )),
            ),
            MaterialButton(
              color: Colors.redAccent,
              onPressed: () {
                insidePage(s).deleteAll();
              },
              child: Text("Delete all passwords"),
            ),
            SizedBox(height: 10),
            MaterialButton(
              color: Colors.redAccent,
              onPressed: () {
                creditCard(s).deleteAll();
              },
              child: Text("Delete all cards"),
            ),
            SizedBox(height: 10),
            MaterialButton(
              color: Colors.redAccent,
              onPressed: () {
                notePage(s).deleteAll();
              },
              child: Text("Delete all notes"),
            ),
            SizedBox(
              height: 90,
            )
          ],
        )));
  }
}
