import 'package:flutter/material.dart';
import 'package:password_safe/Passwords.dart';
import 'BottomAppBar.dart';
import 'Account.dart';
import 'Login.dart';

class CardInfo {
  String title, name;
  int number, CVV, year, month, pin;
  CardInfo(this.title, this.name, this.number, this.CVV, this.month, this.year);
}

List<CardInfo> card = [];

final _titleController = TextEditingController();
final _nameController = TextEditingController();
final _cardNumberController = TextEditingController();
final _CVVController = TextEditingController();
final _monthControler = TextEditingController();
final _yearController = TextEditingController();

var CARDLIST;

final message = SnackBar(
  content: Text(
    "Card saved successfully"
  ), duration: Duration(
  seconds: 3,
)
);

final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

class CreditCard extends StatefulWidget {
  var s;
  CreditCard(this.s);
  creditCard createState() => creditCard(s);
}

class creditCard extends State<CreditCard> {
  void initState() {
    super.initState();
    CARDLIST =  accountPass[Info.ID].cardList;
  }

  var s;
  creditCard(this.s);

  Widget sampleCard() {
    return Container(
      child: AlertDialog(
          content: Container(
              height: 200,
              width: 500,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: TextFormField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            hintText: "Enter card name",
                          )),
                    ),
                    Container(
                      child: TextFormField(
                        controller: _cardNumberController,
                        decoration: InputDecoration(
                          hintText: "Enter card number",
                        ),
                      ),
                    ),
                    Container(
                      child: TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: "Enter cardholder name",
                          )),
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              width: 30,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "MM",
                                ),
                                controller: _monthControler,
                              ),
                            ),
                            Text("/"),
                            Container(
                              alignment: Alignment.topLeft,
                              width: 30,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: "YY",
                                ),
                                controller: _yearController,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          width: 80,
                          child: TextFormField(
                              controller: _CVVController,
                              decoration: InputDecoration(
                                hintText: "CVV",
                              )),
                        ),
                      ],
                    ),
                    FlatButton(
                      child: Text("Save"),
                      color: Colors.redAccent,
                      onPressed: () {
                        _key.currentState.showSnackBar(message);
                        setState(() {
                          CARDLIST.add(CardInfo(
                                _titleController.text.toString(),
                                _nameController.text.toString(),
                                int.parse(
                                    _cardNumberController.text.toString()),
                                int.parse(_CVVController.text.toString()),
                                int.parse(_monthControler.text.toString()),
                                int.parse(_yearController.text.toString()),
                              ));
                          print(CARDLIST.length);
                            try {
                              Navigator.pop(context);
                            } catch (e) {
                              throw e;
                            }
                        });
                      },
                    )
                  ],
                ),
              ))),
    );
  }

  void deleteAll() {
    card.clear();
    CARDLIST.clear();
  }

  void addCreditCardItem() async {
    _titleController.text = "";
    _nameController.text = "";
    _cardNumberController.text = "";
    _CVVController.text = "";
    _monthControler.text = "";
    _yearController.text = "";
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return sampleCard();
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        floatingActionButton: FloatingActionButton(
          heroTag: "1",
          backgroundColor: Colors.redAccent,
          child: Icon(Icons.add),
          onPressed: () {
            addCreditCardItem();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBarClass(s).BottomAppBarWidget(context),
        body: CARDLIST.length == 0
            ? Container(
                alignment: Alignment.center,
                child: Text("No cards. Press the + button to add a card",
                    style: TextStyle(
                      fontSize: 40,
                    )),
              )
            : CardList());
  }

  Widget CardList() {
    return Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: CARDLIST.length,
              itemBuilder: (context, index) {
                final card_item = CARDLIST[index];
                return CardItem(index, card_item);
              }),
        )
      ],
    );
  }

  Widget CardItem(int _index, var _cardItem) {
    return Card(
      child: ListTile(
          title: Row(
            children: [
              Text(
                _cardItem.title,
              ),
              SizedBox(width: 260),
              IconButton(
                icon: Icon(
                  Icons.delete,
                ),
                onPressed: () {
                  setState(() {
                    print(CARDLIST.length);
                    try {
                      CARDLIST.removeAt(_index);
                    } catch (e) {
                      throw e;
                    }
                  });
                },
              ),
            ],
          ),
          subtitle: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text("Name: ${_cardItem.name}"),
                SizedBox(
                  height: 10,
                ),
                Text("No.: ${_cardItem.number}"),
                SizedBox(
                  height: 10,
                ),
                Text("CVV: ${_cardItem.CVV}"),
                SizedBox(
                  height: 10,
                ),
                Text('Date: ${_cardItem.month}/${_cardItem.year}'),
              ],
            ),
          )),
    );
  }
}
