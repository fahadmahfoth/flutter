import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:herfa_test/screen/addcard.dart';
import 'package:herfa_test/screen/updatecard.dart';
import 'package:herfa_test/user/usertoken.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _tabsHomeState createState() => _tabsHomeState();
}

class _tabsHomeState extends State<Profile> {
  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  SignUp guser = SignUp();

  Future<Null> _refresh() async {
    setState(() {
      guser.getUser();
    });

    return null;
  }

  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? null;
    if (value == null) {
      Navigator.of(context).pushReplacementNamed("login");
    }
  }

  @override
  void initState() {
    read();
    super.initState();
    guser.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //  decoration: buildBoxDecoration(),

      child: FutureBuilder(
        future: guser.getUser(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            var mydata = snapshot.data;
            // print(mydata["id"]);
            return RefreshIndicator(
              onRefresh: _refresh,
              child: new Newscard(
                user_id: mydata['key'],
                name: mydata['name'],
                email: mydata['email'],
                created_at: mydata['created_at'],
                updated_at: mydata['updated_at'],
              ),
            );
          } else {
            return Center(
              child: new CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return new BoxDecoration(color: Colors.white);
  }
}

class Newscard extends StatelessWidget {
  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  Newscard(
      {this.user_id, this.name, this.email, this.created_at, this.updated_at});
  final int user_id;
  final String name;
  final String email;
  final String created_at;
  final String updated_at;

  var value;

  readcard() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'addcard';
    value = prefs.get(key) ?? null;
    // print(value);
  }

  SignUp getcard = SignUp();

  @override
  Widget build(BuildContext context) {


    return FutureBuilder(
      future: getcard.getusercard(user_id),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          var cardData = snapshot.data;
          var key = cardData["key"];
          var name = cardData["user name"];
          var Job = cardData["Job"];
          var numPhone = cardData["numPhone"];
          var location = cardData["location"];
          return Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                  icon:Icon(CupertinoIcons.pen),
                   onPressed: (){
                     Navigator.push(context, MaterialPageRoute(
                       builder: (context){
                         return UpdatePageOne(user_id);
                       }
                     ));
                   },
                )
              ],
              title: Text('البطاقة التعريفية',style:TextStyle(color: Colors.black)),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              automaticallyImplyLeading: false,
            ),
            body: Container(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "الاسم",
                      textAlign: TextAlign.right,
                    ),
                    subtitle: Text(
                      name,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                                    Padding(padding: EdgeInsets.fromLTRB(100, 2, 5, 2),child: Divider(color: Colors.black,),),

                  ListTile(
                    title: Text(
                      "الايميل",
                      textAlign: TextAlign.right,
                    ),
                    subtitle: Text(
                      email,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "رقم الهاتف",
                      textAlign: TextAlign.right,
                    ),
                    subtitle: Text(
                      numPhone,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                                    Padding(padding: EdgeInsets.fromLTRB(100, 2, 5, 2),child: Divider(color: Colors.black,),),

                  
                  ListTile(
                    title: Text(
                      "الحرفة",
                      textAlign: TextAlign.right,
                    ),
                    subtitle: Text(
                      Job,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "العنوان",
                      textAlign: TextAlign.right,
                    ),
                    subtitle: Text(
                      location,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
