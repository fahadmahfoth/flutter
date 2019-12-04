import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Herfa/screen/updatecard.dart';
import 'package:Herfa/user/usertoken.dart';
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
    }else{
    final prefs2 = await SharedPreferences.getInstance();
    final key = 'p';
    final value = prefs2.get(key) ?? false;
    print(value);
    if (!value&&value==false) {
      print(value.toString());
      Navigator.of(context).pushReplacementNamed("addcard");
    }
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
      padding: EdgeInsets.all(5),
      child: FutureBuilder(
        future: guser.getUser(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            var mydata = snapshot.data;
           print(mydata["id"]);
           print(mydata["is_stuff"]);

            return new Newscard(
              user_id: mydata['id'],
              name: mydata['name'],
              email: mydata['email'],
              is_stuff: mydata["is_stuff"],
              created_at: mydata['created_at'],
              updated_at: mydata['updated_at'],
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
      {this.user_id, this.name, this.email,this.is_stuff, this.created_at, this.updated_at});
  final int user_id;
  final String name;
  final String email;
  final String is_stuff ;
  final String created_at;
  final String updated_at;


  var value;

  readcard() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'addcard';
    value = prefs.get(key) ?? null;
    // print(value);MyCard
  }

  SignUp getcard = SignUp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getcard.getusercard(user_id),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          var cardData = snapshot.data;
          var keys = cardData["id"];
          var name = cardData["User name"];
          var Job = cardData["Job"];
          var numPhone = cardData["Phone"];
          var location = cardData["Location"];
          return Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop,

            floatingActionButton: FloatingActionButton.extended(
              backgroundColor: Colors.green,

              label: Text("تعديل"),
              onPressed: (){
                 Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return UpdatePageOne(
                        user_id,keys
                      );
                    }));

              },
              
            ),
            appBar: AppBar(
              title: Text('البطاقة التعريفية',
                  style: TextStyle(color: Color(0xff384064))),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              automaticallyImplyLeading: false,
            ),
            body: Card(
              shape: Border(
                bottom: BorderSide(color: Colors.black.withOpacity(0.5)),
                left: BorderSide(color: Colors.black.withOpacity(0.5)),
                right: BorderSide(color: Colors.black.withOpacity(0.5)),
                top: BorderSide(color: Colors.black.withOpacity(0.5)),
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        "الاسم",
                        textAlign: TextAlign.right,
                        style: TextStyle(color:Color(0xff384064) ),
                      ),
                      subtitle: Text(
                        name.toString(),
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 25,color: Color(0xff384064)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(100, 2, 5, 2),
                      child: Divider(
                        color: Colors.black,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "الايميل",
                        textAlign: TextAlign.right,
                            style: TextStyle(color:Color(0xff384064) )
                      ),
                      subtitle: Text(
                        email.toString(),
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 25,color:Color(0xff384064)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(100, 2, 5, 2),
                      child: Divider(
                        color: Colors.black,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "رقم الهاتف",
                        textAlign: TextAlign.right,
                            style: TextStyle(color:Color(0xff384064) )
                      ),
                      subtitle: Text(
                        numPhone.toString(),
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 25,color:Color(0xff384064)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(100, 2, 5, 2),
                      child: Divider(
                        color: Colors.black,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "الحرفة",
                        textAlign: TextAlign.right,
                            style: TextStyle(color:Color(0xff384064) )
                      ),
                      subtitle: Text(
                        Job,
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 25,color:Color(0xff384064)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(100, 2, 5, 2),
                      child: Divider(
                        color: Colors.black,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "العنوان",
                        textAlign: TextAlign.right,
                            style: TextStyle(color:Color(0xff384064) )
                      ),
                      subtitle: Text(
                        location,
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 25,color: Color(0xff384064)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(100, 2, 5, 10),
                      child: Divider(
                        color: Colors.black,
                      ),
                    ),
                   is_stuff.contains("1")? Padding(
                      padding: EdgeInsets.only(bottom: 25),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 18,
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: OutlineButton(
                          highlightColor: Colors.green,
                          highlightedBorderColor: Colors.green,
                          borderSide:
                              BorderSide(style: BorderStyle.solid, width: 1),
                          focusColor: Colors.green,
                          color: Colors.green,
                          child: Text("اضافة حرفة",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 20,
                                  color: Colors.green)),
                          onPressed: () {
                            
                            Navigator.pushReplacementNamed(
                                context, "addserv");
                          },
                        ),
                      ),
                    ):Padding(padding: EdgeInsets.all(0),),
                    Padding(
                      padding: EdgeInsets.only(bottom: 25),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 18,
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: OutlineButton(
                          highlightColor: Colors.red,
                          highlightedBorderColor: Colors.red,
                          borderSide:
                              BorderSide(style: BorderStyle.solid, width: 1),
                          focusColor: Colors.red,
                          color: Colors.red,
                          child: Text("تسجيل خروج",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 20,
                                  color: Colors.red)),
                          onPressed: () {
                            _save(null);
                            Navigator.pushReplacementNamed(
                                context, "interface");
                          },
                        ),
                      ),
                    ),
                     
                  ],
                ),
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