import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Herfa/screen/cards.dart';
import 'package:Herfa/user/usertoken.dart';

import 'cards.dart';

class Serves extends StatefulWidget {
  @override
  _ServesState createState() => _ServesState();
}

class _ServesState extends State<Serves> {
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
                        Text(
                          "الحرف المتوفرة",
                          style: TextStyle(fontSize: 30),
                        ),
                        Divider(
                          color: CupertinoColors.darkBackgroundGray,
                        ),
                        Expanded(
                          child: GridView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int i) {
// Text(snapshot.data[i]["name"].toString()),
                              var mydata = snapshot.data[i];
                              return Container(
                                child: NewServ(
                                    //  key:mydata["key"],
                                    job_name: mydata["name"]),
                              );
                            },
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
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
}

class NewServ extends StatelessWidget {
  NewServ({this.job_name});
  var job_name;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Container(
        color: CupertinoColors.extraLightBackgroundGray,
        child: OutlineButton(
          highlightedBorderColor: Colors.red,
          borderSide:
              BorderSide(width: 1, color: Colors.black.withOpacity(0.4)),
          child: Text(
            "$job_name",
            style:
                TextStyle(color: Colors.black.withOpacity(0.7), fontSize: 25),
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
