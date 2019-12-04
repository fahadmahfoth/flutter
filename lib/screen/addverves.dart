import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddServ extends StatefulWidget {
 
  @override
  _AddServState createState() => _AddServState();
}

class _AddServState extends State<AddServ> {

  TextEditingController _controller = new TextEditingController();

  void addData(String name) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? null;

    String myUrl = "http://herfa.codeforiraq.org/api/auth/jobs";
    http.post(myUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }, body: {
      "name": "$name",
    }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text("اضافة حرفة جديدة"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 50, 50, 10),
              child: TextField(
                controller: _controller,
                textAlign: TextAlign.right,
                maxLength: 150,
                autofocus: true,
                enableInteractiveSelection: false,
                cursorColor: CupertinoColors.destructiveRed,
                decoration: InputDecoration(
                    hintText: "اسم الحرفة", border: InputBorder.none),
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
                  print(_controller.text);
            
                    addData(_controller.text);
                  Navigator.pushNamed(context, "interface");
                  
                 
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
 
}
