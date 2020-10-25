import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'BottomAppBar.dart';
import 'Login.dart';
import 'Account.dart';

class Password {
  String _site;
  String _password;
  int ID;
  bool _delete;
  Password(this._site, this._password, this._delete, this.ID);
}

class SearchPasswords {
  String _site;
  String _password;
  int ID;
  bool _delete;
  SearchPasswords(this._site, this._password, this._delete, this.ID);
}

final GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
var PASS;

List<Password> passwordList = [];
List<SearchPasswords> _searchPasswords = [];

var saveNewPassword = new List(2);

bool searchBarTapped;

String search;
String _value;

class InsidePage extends StatefulWidget {
  var s;
  InsidePage(this.s);
  insidePage createState() => insidePage(s);
}

String newPassword, newSite;

final searchController = TextEditingController();

class insidePage extends State<InsidePage> {
  int selectedIndex = 1;
  var s;
  insidePage(this.s);

  void initState() {
    super.initState();
    PASS = accountPass[Info.ID].pass;
    searchBarTapped = false;
    selectedIndex = 1;
    if (saveNewPassword[0] != "" && saveNewPassword[0] != null) {
      passwordList.add(Password(saveNewPassword[1], saveNewPassword[0], true, IDNumber));
      PASS.add(Password(saveNewPassword[1], saveNewPassword[0], true, IDNumber));
      saveNewPassword[0] = "";
      saveNewPassword[1] = "";
    }
  }

  void deleteAll() {
    PASS.clear();
  }

  void addPasswordItem(context, _password, bool add) async {
    final _pController = TextEditingController();
    final _sController = TextEditingController();

    if (_password != "" && _password != null) {
      _pController.text = _password;
    }
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: AlertDialog(
              title: Text("Set Password"),
              content: Container(
                height: 200,
                child: Column(
                  children: [
                    Container(
                      child: TextField(
                        decoration:
                            InputDecoration(hintText: "Enter website name"),
                        controller: _sController,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: TextField(
                        controller: _pController,
                        decoration: InputDecoration(hintText: "Enter password"),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: 200,
                      height: 50,
                      child: MaterialButton(
                        child: Text("Save Password"),
                        color: Colors.redAccent,
                        onPressed: () {
                          addFunc(add, _pController, _sController, _password);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }



  void addFunc(var add, _pController, _sController, _password) {
    if (add) {
      setState(() {
        newPassword = _pController.text.toString();
        newSite = _sController.text.toString();
        passwordList.add(Password(newSite, newPassword, false, Info.ID + 1)); // IDNumber
        PASS.add(Password(newSite, newPassword, false, Info.ID));
        print(PASS.length);
        showSnackBar("Password added");
      });
    } else {
      saveNewPassword[0] = _password;
      saveNewPassword[1] = _sController.text.toString();
    }
    Navigator.pop(context);
  }

  void deleteItem(int index) {
    passwordList.removeAt(index);
    PASS.removeAt(index);
  }

  void showSnackBar(String message) {
    key.currentState.showSnackBar(SnackBar(
     // backgroundColor: Colors.black12,
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
        floatingActionButton: FloatingActionButton(
          heroTag: "1",
          backgroundColor: Colors.redAccent,
          child: Icon(Icons.add),
          onPressed: () {
            addPasswordItem(context, "", true);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBarClass(s).BottomAppBarWidget(context),
      body: PASS.length == 0
            ? Container(
                alignment: Alignment.center,
                child:
                    Text("No passwords. Press the + button to add a password",
                        style: TextStyle(
                          fontSize: 40,
                        )),
              )
            : Stack(
                children: [
                  Flex(
                    direction: Axis.vertical,
                    children: [
                      SizedBox(height: 20),
                      searchBar(),
                      searchBarTapped
                          ? searchPasswords()
                          : AccountPassClass(),
                    ],
                  )
                ],
              ));
  }

  Widget searchBar() {
    return Container(
      child: Row(
        children: [
          Container(
            width: 360,
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                  hintText: "Enter search value...",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              onTap: () {
                _searchPasswords.clear();
              },
              onChanged: (value) {
                _value = value;
              },
              onSubmitted: (value) {
                _value = value;
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _searchPasswords.clear();
              setState(() {
                search = _value;
                if (_value == "") {
                  searchBarTapped = false;
                  if (_searchPasswords.length != 0) {
                    _searchPasswords.clear();
                  }
                } else {
                  searchBarTapped = true;
                }
              });
            },
          )
        ],
      ),
    );
  }

  Widget searchPasswords() {
    int _results = 0;
    for (int i = 0; i <= passwordList.length - 1; i++) {
      if (passwordList[i]._site.contains(search)) {
        _results++;
        if (!passwordList.contains(i)) {
          _searchPasswords.add((SearchPasswords(
              passwordList[i]._site, passwordList[i]._password, false, IDNumber)));
        }
      }
    }
    if (_results != 0) {
      return Expanded(
          child: ListView.builder(
              itemCount: _searchPasswords.length,
              itemBuilder: (context, index) {
                final search_item = _searchPasswords[index];
                return PasswordItem(index, search_item);
              }));
    } else {
      return Text("$_results results");
    }
  }

  Widget AccountPassClass() {
    return Expanded(
      child: ListView.builder(
          itemCount: PASS.length,
          itemBuilder: (context, index) {
            final password_item = PASS[index];
            return PasswordItem(index, password_item);
          }),
    );
  }

  Widget PasswordItem(int index, var p) {
    return index == 0
        ? Padding(
            padding: EdgeInsets.only(top: 5),
            child: Card(
                child: ListTile(
              leading: Text(p._site),
              title: Container(
                alignment: Alignment.topRight,
                child: Text(
                  p._password,
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    deleteItem(index);
                      showSnackBar("Password deleted");
                    });
                },
              ),
            )))
        : Card(
            child: ListTile(
            leading: Text(p._site),
            title: Container(
              alignment: Alignment.topRight,
              child: Text(
                p._password,
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  deleteItem(index);
                });
              },
            ),
          ));
  }
}
