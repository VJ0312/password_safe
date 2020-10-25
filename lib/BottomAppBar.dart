import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'settings.dart';
import 'PasswordGenerator.dart';
import 'Account.dart';
import 'AllItems.dart';

class BottomAppBarClass extends StatelessWidget {
  var s;
  BottomAppBarClass(this.s);
  Widget build(BuildContext context) {
    return Scaffold();
  }
  Widget BottomAppBarWidget(context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          IconButton(
            color: Colors.redAccent,
            icon: Icon(
              MdiIcons.accountKey,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AllItems(s)
              ));
            },
          ),
          SizedBox(
            width: 40,
          ),
          IconButton(
            color: Colors.redAccent,
            icon: Icon(
              MdiIcons.arrowVerticalLock,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => PasswordGenerator(s)
              ));
            },
          ),
          SizedBox(
            width: 100,
          ),
          IconButton(
            color: Colors.redAccent,
            icon: Icon(
              Icons.settings,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Settings(s)
              ));
            },
          ),
          SizedBox(
            width: 40,
          ),
          IconButton(
            color: Colors.redAccent,
            icon: Icon(
              Icons.account_circle,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Account(s)
              ));
            },
          ),
        ],
      ),
    );
  }
}




