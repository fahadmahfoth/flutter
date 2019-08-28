import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:herfa_test/screen/cards.dart';
import 'package:herfa_test/user/usertoken.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'cards.dart';

class UpdatePageOne extends StatefulWidget {
  int user_id;
  int keys;
  UpdatePageOne(this.user_id, this.keys);
  @override
  _ServesState createState() => _ServesState(keys, user_id);
}

class _ServesState extends State<UpdatePageOne> {
  int user_id;
  int keys;
  _ServesState(this.keys, this.user_id);
  SignUp gser = SignUp();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gser.getServ();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: gser.getServ(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                title: Text(
                  "اختر حرفتك ",
                ),
                centerTitle: true,
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "addser");
                },
                label: Text("اضافة حرفة"),
                backgroundColor: CupertinoColors.destructiveRed,
                icon: Icon(Icons.add),
              ),
              body: Center(
                child: new Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width - 10,
                    child: Column(
                      children: <Widget>[
                        Divider(
                          color: CupertinoColors.darkBackgroundGray,
                        ),
                        Expanded(
                          child: GridView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int i) {
// Text(snapshot.data[i]["name"].toString()),
                              var mydata = snapshot.data[i];
                              //  print(mydata["key"]);
                              return Container(
                                child: NewServ(
                                    keys: keys,
                                    user_id: user_id,
                                    ser_id: mydata["key"],
                                    name: mydata["name"]),
                              );
                            },
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                          ),
                        ),
                      ],
                    )),
              ));
        } else {
          return Container(
              color: Colors.white,
              child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}

class NewServ extends StatelessWidget {
  int user_id;
  int keys;
  String name;

  int ser_id;
  NewServ({this.keys, this.user_id, this.ser_id, this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: OutlineButton(
        highlightedBorderColor: Colors.transparent,
        borderSide: BorderSide(width: 1, color: Colors.black.withOpacity(0.4)),
        child: Text(
          "$name",
          style: TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 20),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            // print(job_name);
            return UpdatePageTwo(
              keys: keys,
              user_id: user_id,
              ser_id: ser_id,
            );
          }));
        },
      ),

      // color: Colors.red[200],
    );
  }
}

class UpdatePageTwo extends StatefulWidget {
  int user_id;
  int keys;
  int ser_id;
  UpdatePageTwo({this.keys, this.user_id, this.ser_id});
  @override
  _AddServState createState() =>
      _AddServState(keys: keys, user_id: user_id, ser_id: ser_id);
}

class _AddServState extends State<UpdatePageTwo> {
  int user_id;
  int keys;
  int ser_id;
  _AddServState({this.keys, this.user_id, this.ser_id});
  TextEditingController _controller = new TextEditingController();
  TextEditingController _phcontroller = new TextEditingController();

  SignUp addcard = SignUp();

  //     _saveadd(String useradd) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final key = 'addcard';
  //   final value = useradd;
  //   prefs.setString(key, value);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text("تعديل الحرفة "),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 50, 50, 10),
              child: TextField(
                controller: _phcontroller,
                textAlign: TextAlign.right,
                maxLength: 11,
                autofocus: true,
                keyboardType: TextInputType.number,
                enableInteractiveSelection: false,
                cursorColor: CupertinoColors.destructiveRed,
                decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    hintText: "رقم الهاتف",
                    border: InputBorder.none),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 50, 50, 10),
              child: TextField(
                controller: _controller,
                textAlign: TextAlign.right,
                maxLength: 100,
                autofocus: true,
                enableInteractiveSelection: false,
                cursorColor: CupertinoColors.destructiveRed,
                decoration: InputDecoration(
                    icon: Icon(Icons.map),
                    hintText: "العنوان",
                    border: InputBorder.none),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 15, 60, 15),
              child: RaisedButton(
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
                  child: Text(
                    "اضافة ",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                color: CupertinoColors.destructiveRed,
                disabledColor: Colors.grey,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
                onPressed: () {
                  print(ser_id);
                  print(user_id);
                  addcard.updateCardData(
                      keys: keys,
                      user_id: user_id,
                      service_id: ser_id,
                      numPhone: _phcontroller.text.trim(),
                      location: _controller.text);
                  Navigator.pushReplacementNamed(context, "interface");
                  // _saveadd("card added");
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 100, right: 100, top: 10),
              child: OutlineButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[Icon(Icons.forward), Text("رجوع")],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
