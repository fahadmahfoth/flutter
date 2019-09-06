import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Herfa/user/usertoken.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? null;
    if (value != null) {
      Navigator.of(context).pushReplacementNamed("interface");
    }
  }

  readtwo() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? null;
    return value;
  }

  @override
  initState() {
    read();
  }

  SignUp databaseHelper = new SignUp();
  String msgStatus = '';
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();

  final TextEditingController _passwordController = new TextEditingController();

  _onPressed() {
    setState(() {
      if (_nameController.text.isNotEmpty &&
          _emailController.text.trim().toLowerCase().isNotEmpty &&
          _passwordController.text.trim().isNotEmpty) {
        databaseHelper
            .registerData(
                _nameController.text.trim(),
                _emailController.text.trim().toLowerCase(),
                _passwordController.text.trim())
            .whenComplete(() {
          if (databaseHelper.status == false) {
            print(readtwo());
            _showDialog();
            msgStatus = 'Check your information';
          } else {
            Navigator.pushReplacementNamed(context, 'addcard');
            databaseHelper.status = true;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
          Navigator.pushReplacementNamed(context, "login");
        },),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("حرفة"),
        elevation: 0.0,
        backgroundColor: CupertinoColors.lightBackgroundGray,
      ),
      body: DoubleBackToCloseApp(
                snackBar: const SnackBar(
            content: Text('اضغط مرة ثانية للخروج',textAlign: TextAlign.right,),
          ),
              child: Container(
          decoration: new BoxDecoration(
            color: CupertinoColors.lightBackgroundGray,
          ),
          padding: EdgeInsets.only(top: 40),
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ///////////  background///////////
                  new Container(),

                  Positioned(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Card(
                            elevation: 4.0,
                            color: Colors.white,
                            margin: EdgeInsets.only(left: 20, right: 20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  /////////////  Email//////////////

                                  TextField(
                                    style: TextStyle(color: Color(0xFF000000)),
                                    controller: _nameController,
                                    cursorColor: Color(0xFF9b9b9b),
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.grey,
                                      ),
                                      hintText: "Name",
                                      hintStyle: TextStyle(
                                          color: Color(0xFF9b9b9b),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),

                                  TextField(
                                    style: TextStyle(color: Color(0xFF000000)),
                                    controller: _emailController,
                                    cursorColor: Color(0xFF9b9b9b),
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.alternate_email,
                                        color: Colors.grey,
                                      ),
                                      hintText: "Email",
                                      hintStyle: TextStyle(
                                          color: Color(0xFF9b9b9b),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),

                                  /////////////// password////////////////////

                                  TextField(
                                    style: TextStyle(color: Color(0xFF000000)),
                                    cursorColor: Color(0xFF9b9b9b),
                                    controller: _passwordController,
                                    keyboardType: TextInputType.text,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.vpn_key,
                                        color: Colors.grey,
                                      ),
                                      hintText: "Password",
                                      hintStyle: TextStyle(
                                          color: Color(0xFF9b9b9b),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  /////////////  LogIn Botton///////////////////
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: RaisedButton(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 8,
                                            bottom: 8,
                                            left: 10,
                                            right: 10),
                                        child: Text(
                                          "انشاء الحساب",
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
                                          borderRadius:
                                              new BorderRadius.circular(20.0)),
                                      onPressed: _onPressed,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(
              'خطأ',
              textAlign: TextAlign.center,
            ),
            content: new Text(
              'تاكد من كتابة المعلومات بشكل صحيح',
              textAlign: TextAlign.right,
            ),
            actions: <Widget>[
              new OutlineButton(
                child: new Text(
                  'اغلاق',
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
