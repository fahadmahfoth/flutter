import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:herfa_test/user/usertoken.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPageZero extends StatelessWidget {
  SignUp guuser = SignUp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: guuser.getUser(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return AddPageOne(user_id: snapshot.data["key"]);
        } else {
          return Container(
              color: Colors.white,
              child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}

class AddPageOne extends StatefulWidget {
  int user_id;
  AddPageOne({this.user_id});
  @override
  _ServesState createState() => _ServesState(user_id);
}

class _ServesState extends State<AddPageOne> {
  int user_id;
  _ServesState(this.user_id);
  SignUp gser = SignUp();
  @override
  void initState() {
    super.initState();
    gser.getServ();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();

    setState(() {
      gser.getServ();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: gser.getServ(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return SmartRefresher(
            controller: _refreshController,
            onRefresh: _onRefresh,
            child: Scaffold(
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
                )),
          );
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
  String name;
  int ser_id;
  NewServ({this.user_id, this.ser_id, this.name});

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
            return AddPageTwo(
              user_id: user_id,
              ser_id: ser_id,
            );
          }));
        },
      ),
    );
  }
}

class AddPageTwo extends StatefulWidget {
  int user_id;
  int ser_id;
  AddPageTwo({this.user_id, this.ser_id});
  @override
  _AddServState createState() =>
      _AddServState(user_id: user_id, ser_id: ser_id);
}

class _AddServState extends State<AddPageTwo> {
  int user_id;
  int ser_id;
  _AddServState({this.user_id, this.ser_id});
  TextEditingController _controller = new TextEditingController();
  TextEditingController _phcontroller = new TextEditingController();
  SignUp addcard = SignUp();
  _saveadd(String useradd) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'addcard';
    final value = useradd;
    prefs.setString(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  addcard.addCardData(
                      user_id: user_id,
                      service_id: ser_id,
                      numPhone: _phcontroller.text.trim(),
                      location: _controller.text);
                  Navigator.pushReplacementNamed(context, "interface");
                  _saveadd("card added");
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
