import 'package:herfa_test/user/usertoken.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  

  @override
  _MyDrawerState createState() => _MyDrawerState();

}

class _MyDrawerState extends State<MyDrawer> {


  SignUp userdata = SignUp();
  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Drawer(
        
        
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Container(
              //   height: 150,
              //   width: 150,
              //   child: ClipOval(
              //     child: Image.asset(
              //         "assets/codeforiraq.png"),
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.all(10),
              //   child: Divider(
              //     color: Colors.black,
              //   ),
              // ),
              // Expanded(
              //   child: ListView(
              //     children: <Widget>[
              //       Padding(
              //         padding: const EdgeInsets.only(right: 12),
              //         child: Text("المطورين",textAlign: TextAlign.right,),
              //       ),
              //       ListTile(
              //         title: Text(
              //           "فهد محفوظ ",
              //           textAlign: TextAlign.right,
              //         ),
              //         subtitle: Text(
              //           "مُبرمج",
              //           textAlign: TextAlign.right,
              //              style: TextStyle(
              //               color: Colors.red)
              //         ),
              //       ),
              //       ListTile(
              //         title: Text(
              //           "ربيع علي",
              //           textAlign: TextAlign.right,

              //         ),
              //         subtitle: Text(
              //           "مُبرمج",
              //           textAlign: TextAlign.right,

              //           style: TextStyle(
              //               color: Colors.red)
              //         ),
              //       ),
              //       Padding(
              //         padding: EdgeInsets.all(10),
              //         child: Divider(),
              //       ),
              //       ListTile(
              //         title: Text(
              //           "Code for Iraq",
              //           textAlign: TextAlign.center,
                        
              //         ),
              //         subtitle: Text(
              //           "info@codeforiraq@org",
              //           textAlign: TextAlign.center,

              //           style: TextStyle(
              //               fontSize: MediaQuery.of(context).size.width / 23,
              //               color: Colors.red)
              //         ),
              //       ),
                    
              //     ],
              //   ),
              // ),

              Padding(
                padding: EdgeInsets.only(bottom: 50),
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
                        BorderSide(style: BorderStyle.solid, width: 1),
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

            ],
          ),
        
      ),
    );
  }
}
