import 'dart:convert';
import 'dart:io';
import 'package:herfa_test/user/usertoken.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:herfa_test/user/getuser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/gestures.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  _saveadd(String useradd) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'addcard';
    final value = useradd;
    prefs.setString(key, value);
  }

  SignUp userdata = SignUp();
  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 150,
              width: 150,
              child: ClipOval(
                child: Image.network(
                    "https://avatars2.githubusercontent.com/u/39920565?s=460&v=4"),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Divider(
                color: Colors.black,
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "فهد محفوظ ",
                      textAlign: TextAlign.right,
                    ),
                    subtitle: Text(
                      "مُبرمج",
                      textAlign: TextAlign.right,
                         style: TextStyle(
                          color: Colors.red)
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "ربيع",
                      textAlign: TextAlign.right,

                    ),
                    subtitle: Text(
                      "مُبرمج",
                      textAlign: TextAlign.right,

                      style: TextStyle(
                          color: Colors.red)
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Divider(),
                  ),
                  ListTile(
                    title: Text(
                      "Code for Iraq",
                      textAlign: TextAlign.center,
                      
                    ),
                    subtitle: Text(
                      "info@codeforiraq@org",
                      textAlign: TextAlign.center,

                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 23,
                          color: Colors.red)
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(bottom: 100),
            ),

            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                height: MediaQuery.of(context).size.height / 18,
                width: MediaQuery.of(context).size.width / 2.5,
                child: OutlineButton(
                  highlightColor: Colors.white,
                  highlightedBorderColor: Colors.red,
                  borderSide:
                      BorderSide(style: BorderStyle.solid, width: 2),
                  focusColor: Colors.red,
                  color: Colors.red,
                  child: Text("تسجيل خروج",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 20,
                          color: Colors.red)
                          ),
                  onPressed: () {
                    _save(null);
                    _saveadd(null);
                    Navigator.pushReplacementNamed(context, "interface");
                  },
                ),
              ),
            ),
            //  Padding(
            //    padding: EdgeInsets.all(10),
            //    child: Column(
            //      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //      children: <Widget>[
            //        ListTile(

            //          title: Text("فهد محفوظ",textAlign: TextAlign.right,),
            //          subtitle: Text("مبرمج",textAlign: TextAlign.right,),
            //        ),

            //         ListTile(

            //          title: Text("فهد محفوظ",textAlign: TextAlign.right,),
            //          subtitle: Text("مبرمج",textAlign: TextAlign.right,),
            //        ),

            //      ],
            //    ),
            //  ),
          ],
        ),
      ),
    );
  }
}
