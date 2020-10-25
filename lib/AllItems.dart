import 'package:flutter/material.dart';
import 'BottomAppBar.dart';
import 'Passwords.dart';
import 'notes.dart';
import 'CreditCard.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AllItems extends StatefulWidget {
  var s;
  AllItems(this.s);
  allItems createState() => allItems(s);
}

class allItems extends State<AllItems> {
  var s;
  allItems(this.s);
  Widget button(dynamic icon, int num) {
    return Container(
       alignment: Alignment.center,
       child:  IconButton(
         color: Colors.redAccent,
          icon: Icon(icon),
         iconSize: 120,
         onPressed: () {
            switch(num) {
              case 1: Navigator.push(context, MaterialPageRoute(
                  builder: (context) => InsidePage(s))
              );
              break;
              case 2:  Navigator.push(context, MaterialPageRoute(
                  builder: (context) => CreditCard(s))
              );
              break;
              case 3:  Navigator.push(context, MaterialPageRoute(
                  builder: (context) => NotePage(s))
              );
              break;
            }
         },
        ),
    );
  }
  @override
  Widget build (BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "1",
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.add),
        onPressed: () {
          insidePage(s).addPasswordItem(context, "", true);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBarClass(s).BottomAppBarWidget(context),
      body: Column(
        children: [
          Text(
              "All Items", style: TextStyle(
            fontSize: 50,
            )
          ),
          button(Icons.lock_open, 1),
          Text(
            "Passwords", style: TextStyle(
            fontSize: 20,
            )
          ),
          SizedBox(height: 17),
          button(MdiIcons.creditCardPlus, 2),
          Text(
              "Cards", style: TextStyle(
            fontSize: 20,
            )
          ),
          SizedBox(height: 17),
          button(MdiIcons.notePlus, 3),
          Text(
              "Notes", style: TextStyle(
            fontSize: 20,
            )
          ),
        ],
      )
    );
  }
}