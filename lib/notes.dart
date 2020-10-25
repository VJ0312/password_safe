import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'BottomAppBar.dart';
import 'package:password_safe/Account.dart';
import 'Account.dart';
import 'Login.dart';
import 'package:password_safe/Passwords.dart';

class Note {
  String title;
  String content;
  Note(this.title, this.content);
}

class SearchNote {
  String title;
  String content;
  SearchNote(this.title, this.content);
}

List<Note> notes = [];
List<SearchNote> searchNotes = [];

bool searchBarTapped;

String search;

var CARDLIST;

class NotePage extends StatefulWidget {
  var s;
  NotePage(this.s);
  notePage createState() => notePage(s);
}

final searchController = TextEditingController();

class notePage extends State<NotePage> {
  var s;
  notePage(this.s);
  int selectedIndex = 1;
  void initState() {
    super.initState();
    CARDLIST = accountPass[Info.ID].noteList;
    searchBarTapped = false;
    selectedIndex = 1;
  }

  void deleteAll() {
    CARDLIST.clear();
  }

  void addNoteItem(context, _title, _content) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Edit(s)));
  }

  void deleteItem(int index) {
    notes.removeAt(index);
    insidePage(s).showSnackBar("Note deleted");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: "1",
          backgroundColor: Colors.redAccent,
          child: Icon(Icons.add),
          onPressed: () {
            addNoteItem(context, "", "");
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBarClass(s).BottomAppBarWidget(context),
        body: CARDLIST.length == 0
            ? Container(
                alignment: Alignment.center,
                child: Text("No notes. Press the + button to add a note",
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
                      searchBarTapped ? SearchNotes() : AccountPassNotes(),
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
                searchNotes.clear();
              },
              onChanged: (value) {
                search = value;
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              searchNotes.clear();
              setState(() {
                if (search == "") {
                  searchBarTapped = false;
                  if (searchNotes.length != 0) {
                    searchNotes.clear();
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

  Widget SearchNotes() {
    int _results = 0;
    for (int i = 0; i <= notes.length - 1; i++) {
      if (notes[i].title.contains(search) ||
          notes[i].content.contains(search)) {
        _results++;
        if (!notes.contains(i)) {
          searchNotes.add((SearchNote(notes[i].title, notes[i].content)));
        }
      }
    }
    if (_results != 0) {
      return Expanded(
          child: ListView.builder(
              itemCount: searchNotes.length,
              itemBuilder: (context, index) {
                final search_item = searchNotes[index];
                return NoteItem(index, search_item);
              }));
    } else {
      return Text("$_results results");
    }
  }

  Widget AccountPassNotes() {
    return Expanded(
      child: ListView.builder(
          itemCount: CARDLIST.length,
          itemBuilder: (context, index) {
            final note_item = CARDLIST[index];
            return NoteItem(index, note_item);
          }),
    );
  }

  Widget NoteItem(int index, var n) {
    return index == 0
        ? Padding(
            padding: EdgeInsets.only(top: 5),
            child:  Card(
                child: ListTile(
                  title: Text(n.title),
                  subtitle: Text(
                    n.content,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        deleteItem(index);
                      });
                    },
                  ),
                )))
        : Card(
            child: ListTile(
            title: Text(n.title),
            subtitle: Text(
              n.content,
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

class Edit extends StatefulWidget {
  var s;
  Edit(this.s);
  edit createState() => edit(s);
}

class edit extends State<Edit> {
  var s;
  edit(this.s);
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  void addNote() {
    notes.add(Note(_titleController.text.toString(),
        _contentController.text.toString()));
    CARDLIST.add(Note(_titleController.text.toString(),
        _contentController.text.toString()));
    Navigator.push(context,
        MaterialPageRoute(builder: (content) => NotePage(s)));
    insidePage(s).showSnackBar("Note added");
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
                controller: _titleController,
                decoration: InputDecoration(
                    hintText: "Enter a title", border: InputBorder.none)),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                  hintText: "Enter content", border: InputBorder.none),
              maxLines: 20,
            ),
            MaterialButton(
              child: Text("Save Note"),
              color: Colors.redAccent,
              onPressed: () {
                setState(() {
                  addNote();
                });
              },
            ),
          ],
        ));
  }
}
