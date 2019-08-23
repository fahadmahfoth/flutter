import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:herfa_test/screen/addcard.dart';
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

  Newscard({this.user_id, this.name, this.email, this.created_at, this.updated_at});
  final int user_id;
  final String name;
  final String email;
  final String created_at;
  final String updated_at;

var value;
  
 readcard() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'addcard';
    value = prefs.get(key ) ?? null;
    print(value);
  }


  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return new Scaffold(
        backgroundColor: Colors.transparent,
        body: new Container(
            child: new Column(
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.only(left: _width / 8, right: _width / 8),
            ),
            new SizedBox(
              height: _height / 20,
            ),
            new Text(
              '$name',
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: _width / 15,
                  color: Colors.black.withOpacity(0.9)),
            ),
            new Padding(
              padding: new EdgeInsets.only(
                  top: _height / 15, left: _width / 8, right: _width / 8),
            ),
            new Padding(
              padding: new EdgeInsets.only(left: _width / 8, right: _width / 8),
              child: new Text(
                email,
                style: new TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: _width / 25,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: new Divider(
                height: _height / 30,
                color: Colors.black,
              ),
            ),

             
              Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                // height: MediaQuery.of(context).size.height / 15,
                // width: MediaQuery.of(context).size.width / 2.5,
                child: OutlineButton(
                  borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.5), width: 2),
                  focusColor: Colors.red,
                  color: Colors.red,
                  child: Text(
                    
                    readcard()==null?"انشاء بطاقة ":"تعديل البطاقة",
                    style: TextStyle(fontSize: 25),
                  ),
                  onPressed: () {
                  //  print(id);
                  readcard()==null?  Navigator.push(context, MaterialPageRoute(
                      builder: (context){
                        return AddPageOne(user_id);
                      }
                    )):print("object");

                    readcard();
                  },
                ),
              ),
            ),
          
         
          ],
        )));
  }

}
