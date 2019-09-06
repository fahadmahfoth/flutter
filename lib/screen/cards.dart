import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Herfa/user/usertoken.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

var mydata;

class Cards extends StatefulWidget {
  Cards({this.job_name});
  var job_name;

  @override
  _tabsHomeState createState() => _tabsHomeState(job_name);
}

class _tabsHomeState extends State<Cards> {
  String uri = "";

  _tabsHomeState(this.job_name);

  String job_name;
  SignUp gcard = SignUp();

  @override
  void initState() {
    super.initState();
    gcard.getCard(job_name);
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
                  appBar: AppBar(
                    title: Text(
                      "$job_name",
                      style: TextStyle(color: Color(0xff384064)),
                    ),
                    centerTitle: true,
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    automaticallyImplyLeading: false,
                  ),
                  floatingActionButton: FloatingActionButton.extended(
                    label: Row(
                      children: <Widget>[

                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                          Text(
                          "رجوع",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    highlightElevation: 0.0,
                    isExtended: true,
                    foregroundColor: CupertinoColors.darkBackgroundGray,
                    elevation: 0.0,
                  ),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.startTop,
                  body: DoubleBackToCloseApp(
                    snackBar: const SnackBar(
                      content: Text(
                        'اضغط مرة ثانية للخروج',
                        textAlign: TextAlign.right,
                      ),
                    ),
                    child: Container(
                        padding: const EdgeInsets.only(top: 10.0),
                        alignment: Alignment.center,
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            // Padding(
                            //   padding: EdgeInsets.only(left: 20, right: 20),
                            //   child: Divider(
                            //     color: Colors.black,
                            //   ),
                            // ),
                            _search_in_body(),
                            new Expanded(
                                child: new ListView.builder(
                                    itemCount: snapshot.toString().contains(uri)
                                        ? snapshot.data.length
                                        : 0,
                                    itemBuilder: (context, int i) {
                                      return mydata[i].toString().contains(uri)
                                          ? new Newscard(
                                              id: mydata[i]['key'],
                                              user_name: mydata[i]['user name'],
                                              job: mydata[i]['Job'],
                                              numPhone: mydata[i]['numPhone'],
                                              location: mydata[i]['location'],
                                            )
                                          : Padding(
                                              padding: EdgeInsets.all(0),
                                            );
                                    })),
                          ],
                        )),
                  ));
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

  Widget _search_in_body() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: TextField(
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            border: InputBorder.none,
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(10.0),
            //   borderSide: BorderSide(
            //     color: Colors.white,
            //   ),
            // ),

            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            hintText: "ابحث   -الاسم - المنطقة - رقم الهاتف",
            hintStyle: TextStyle(
              fontSize: 15.0,
              color: Color(0xff384064),
            ),
          ),
          maxLines: 1,
          onChanged: (String value) {
            setState(() {
              uri = value;
            });
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
    return Column(
      children: <Widget>[
        new ExpansionTile(
          initiallyExpanded: false,
          trailing: Icon(Icons.arrow_drop_down_circle),
          title: Text(
            user_name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, color: Color(0xff384064)),
          ),
          children: <Widget>[
            Container(
              child: Card(
                // color: Colors.white.withOpacity(0.75),

                child: new Column(children: <Widget>[
                  new ListTile(
                    title: new Text(
                      "رقم هاتف :  $numPhone",
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(fontSize: 25.0, color: Color(0xff384064)),
                    ),
                    subtitle: Text(
                      "المكان : $location ",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 25, color: Color(0xff384064)),
                    ),
                  )
                ]),
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.all(20))
      ],
    );

    //  Container(
    //   padding: EdgeInsets.all(10),
    //   child: Card(
    //     // color: Colors.white.withOpacity(0.75),
    //     child: OutlineButton(
    //       onPressed: () {},
    //       child: new Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: <Widget>[
    //           Stack(alignment: Alignment.center, children: <Widget>[
    //             Container(
    //                 height: MediaQuery.of(context).size.height * 8 / 100,
    //                 width: double.infinity,
    //                 padding: EdgeInsets.all(5),
    //                 decoration: new BoxDecoration(
    //                     borderRadius: new BorderRadius.only(
    //                         //topLeft:  const  Radius.circular(40.0),
    //                         bottomLeft: const Radius.circular(00.0))),
    //                 child: Text(
    //                   "$user_name".toUpperCase()[0] +
    //                       "$user_name".replaceRange(0, 1, ""),
    //                   style: TextStyle(fontSize: 24.0),
    //                   textAlign: TextAlign.center,
    //                 )),
    //           ]),
    //           Padding(
    //             padding: const EdgeInsets.only(
    //                 left: 50, right: 50, bottom: 5, top: 5),
    //             child: Divider(
    //               color: Color.fromRGBO(49, 185, 163, 0.93),
    //             ),
    //           ),
    //           new ListTile(
    //             title: new Text(
    //               "رقم هاتف :  $numPhone",
    //               textAlign: TextAlign.right,
    //               style: TextStyle(
    //                 fontSize: 18.0,
    //               ),
    //             ),
    //             subtitle: Text(
    //               "المكان : $location ",
    //               textAlign: TextAlign.right,
    //               style: TextStyle(fontSize: 20),
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
