import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Herfa/screen/cards.dart';
import 'package:Herfa/user/usertoken.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'cards.dart';

class Serves extends StatefulWidget {
  @override
  _ServesState createState() => _ServesState();
}

class _ServesState extends State<Serves> {
  String uri = "";
  SignUp gser = SignUp();

  @override
  void initState() {
    super.initState();
    gser.getServ();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: gser.getServ(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: new Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width - 20,
                    child: Column(
                      children: <Widget>[
                        // Text(
                        //   "الحرف المتوفرة",
                        //   style: TextStyle(fontSize: 30),
                        // ),
                        // Divider(
                        //   color: CupertinoColors.darkBackgroundGray,
                        // ),
                        _search_in_body(),
                        Expanded(
                          child: ListView.builder(

                            // decoration: InputDecoration(hintText: "البحث",
                            // alignLabelWithHint: true,
                            // border: InputBorder.none,
                            // hintStyle: TextStyle(
                              
                            // )
                            
                            // ),
                            
                            // onChanged: (String value) {
                            //   setState(() {
                            //     uri = value;
                            //   });
                            // },

                            itemCount: snapshot.toString().contains(uri)?snapshot.data.length:0,
                            itemBuilder: (BuildContext context, int i) {
// Text(snapshot.data[i]["name"].toString()),
                              var mydata = snapshot.data[i];

                              return mydata["name"].toString().contains(uri)? Container(
                                child: NewServ(
                                    //  key:mydata["key"],
                                    job_name: mydata["name"]),
                              ):Padding(padding: EdgeInsets.all(0),);
                            },
                            //   gridDelegate:
                            //       SliverGridDelegateWithFixedCrossAxisCount(
                            //           crossAxisCount: 2),
                          ),
                        ),
                      ],
                    )),
              ));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
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
            hintText: "اضغط للبحث في الحرف المتوفرة",
            hintStyle: TextStyle(
              fontSize: 15.0,
              color: Colors.black,
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

class NewServ extends StatelessWidget {
  NewServ({this.job_name});
  var job_name;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 4,
      padding: EdgeInsets.all(5),
      child: Container(
        color: Color(0xffBEB9C0),
        child: OutlineButton(
          highlightedBorderColor: Colors.red,
          borderSide:
              BorderSide(width: 0, color: Color(0xff594663)),
          child: Text(
            "$job_name",
            style:
                TextStyle(color: Color(0xff384064), fontSize: 25),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              // print(job_name);
              return Cards(job_name: job_name);
            }));
          },
        ),
      ),
    );
  }
}
