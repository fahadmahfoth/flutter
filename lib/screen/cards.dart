import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:herfa_test/user/usertoken.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

var mydata;

class Cards extends StatefulWidget {
  Cards({this.job_name});
  var job_name;

  @override
  _tabsHomeState createState() => _tabsHomeState(job_name);
}

class _tabsHomeState extends State<Cards> {
  _tabsHomeState(this.job_name);

  String job_name;
  SignUp gcard = SignUp();

  @override
  void initState() {
    super.initState();
    gcard.getCard(job_name);
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();

    setState(() {
      gcard.getCard(job_name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: new FutureBuilder(
          future: gcard.getCard(job_name),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              mydata = snapshot.data;
              return new Scaffold(
                  floatingActionButton: FloatingActionButton.extended(
                    label: Row(
                      children: <Widget>[
                        Text("رجوع",style: TextStyle(color: Colors.white),),
                        Icon(CupertinoIcons.forward,color: Colors.white,),
                      ],
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    highlightElevation: 0.0,
                    isExtended: true,
                    foregroundColor: CupertinoColors.darkBackgroundGray,
                    // backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    // child: Row(
                    //   children: <Widget>[
                    //     Text("رجوع"),
                    //     Icon(CupertinoIcons.forward),
                    //   ],
                    // ),
                  ),
                  body: Container(
                      padding: const EdgeInsets.only(top: 25.0),
                      alignment: Alignment.center,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "$job_name",
                            style: TextStyle(fontSize: 50),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Divider(
                              color: Colors.black,
                            ),
                          ),
                          new Expanded(
                              child: SmartRefresher(
                                  header: WaterDropHeader(
                                    complete: Text("تمت العملية"),
                                    completeDuration: Duration(seconds: 1),
                                    idleIcon: Icon(Icons.sync),
                                    failed: Icon(Icons.cancel),
                                  ),
                                  enableTwoLevel: true,
                                  controller: _refreshController,
                                  onRefresh: _onRefresh,
                                  child: new ListView.builder(
                                      itemCount: mydata.length,
                                      itemBuilder: (context, int i) {
                                        return new Newscard(
                                          id: mydata[i]['key'],
                                          user_name: mydata[i]['user name'],
                                          job: mydata[i]['Job'],
                                          numPhone: mydata[i]['numPhone'],
                                          location: mydata[i]['location'],
                                        );
                                      }))),
                        ],
                      )));
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: new CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  ),
                  Text("لايوجدحرفيين الى الان"),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: OutlineButton.icon(
                      label: Text("رجوع"),
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class Newscard extends StatelessWidget {
  Newscard({
    this.id,
    this.user_name,
    this.job,
    this.numPhone,
    this.location,
  });
  final int id;
  final String user_name;
  final String job;
  final String numPhone;
  final String location;

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(10),
      child: Card(
        // color: Colors.white.withOpacity(0.75),
        child: OutlineButton(
          onPressed: () {},
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Stack(alignment: Alignment.center, children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height * 8 / 100,
                    width: double.infinity,
                    padding: EdgeInsets.all(5),
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.only(
                            //topLeft:  const  Radius.circular(40.0),
                            bottomLeft: const Radius.circular(00.0))),
                    child: Text(
                      "$user_name".toUpperCase()[0] +
                          "$user_name".replaceRange(0, 1, ""),
                      style: TextStyle(fontSize: 24.0),
                      textAlign: TextAlign.center,
                    )),
              ]),
              Padding(
                padding: const EdgeInsets.only(
                    left: 50, right: 50, bottom: 5, top: 5),
                child: Divider(
                  color: Color.fromRGBO(49, 185, 163, 0.93),
                ),
              ),
              new ListTile(
                title: new Text(
                  "رقم هاتف :  $numPhone",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                subtitle: Text(
                  "المكان : $location ",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
