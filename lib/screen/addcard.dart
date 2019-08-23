import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:herfa_test/screen/cards.dart';
import 'package:herfa_test/user/usertoken.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'cards.dart';

class AddPageOne extends StatefulWidget {
  int user_id;
  AddPageOne(this.user_id);
  @override
  _ServesState createState() => _ServesState(user_id);
}

class _ServesState extends State<AddPageOne> {
  int user_id;
  _ServesState(this.user_id);
  SignUp gser = SignUp();

  @override
  void initState() {
    // TODO: implement initState
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
              ));
        } else {
          return Center(child: CircularProgressIndicator());
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

      // color: Colors.red[200],
    );
  }
}


class AddPageTwo extends StatefulWidget {

      int user_id;
  int ser_id;
  AddPageTwo({this.user_id, this.ser_id});
  @override
  _AddServState createState() => _AddServState(user_id: user_id,ser_id: ser_id);
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
                maxLength: 150,
                autofocus: true,
                keyboardType: TextInputType.number,
                enableInteractiveSelection: false,   
                cursorColor: CupertinoColors.destructiveRed, 
                            

                decoration: InputDecoration(
                  icon: Icon(Icons.phone),
                hintText: "رقم الهاتف",border:InputBorder.none),
              ),
            ),
                        Padding(
              padding: const EdgeInsets.fromLTRB(50, 50, 50, 10),
              child: TextField(
                
                
                controller: _controller,
                textAlign: TextAlign.right,
                maxLength: 11,
                autofocus: true,
                enableInteractiveSelection: false,   
                cursorColor: CupertinoColors.destructiveRed, 
                            

                decoration: InputDecoration(
                  icon: Icon(Icons.map),
                  hintText: "العنوان",border:InputBorder.none),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(60,15, 60, 15),
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
                onPressed: (){
                  addcard.addCardData(
                    user_id: user_id,
                    service_id: ser_id,
                    numPhone: _phcontroller.text.trim(),
                    location: _controller.text
                  );
                  Navigator.pop(context);
                  _saveadd("card added");
                  
                },
              ),
            ),


             Container(
               padding: EdgeInsets.only(left: 100,right: 100,top:10 ),
               child: OutlineButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.forward
                    ),
                    Text("رجوع")
                  ],
                
            ),
            ),
             )
          ],
        ),
      ),
    );
  }
}































// class AddPageTwo extends StatefulWidget {
//   int user_id;
//   int ser_id;
//   AddPageTwo({this.user_id, this.ser_id});
//   @override
//   _HomeState createState() => _HomeState(user_id,ser_id);
// }

// class _HomeState extends State<AddPageTwo> {

//   TextEditingValue _numPhonecontroller;
//   TextEditingController _locationcontroller;

  

//   SignUp addcard = SignUp();
// int user_id;var ser_id;
// _HomeState(this.user_id,this.ser_id);


// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // _numPhonecontroller = TextEditingController();

//     // _locationcontroller = TextEditingController();

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           "اكمل البيانات",
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0.0
        
//         ,
//       ),


// body: Container(
//         padding: EdgeInsets.all(20),
//         child: ListView(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.fromLTRB(50, 50, 50, 10),
//               child: TextField(
                
                
//                 controller: _locationcontroller,
//                 textAlign: TextAlign.right,
//                 maxLength: 150,
//                 autofocus: true,
//                 enableInteractiveSelection: false,   
//                 cursorColor: CupertinoColors.destructiveRed, 
                            

//                 decoration: InputDecoration(hintText: "اسم الحرفة",border:InputBorder.none),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(60,15, 60, 15),
//               child: RaisedButton(
//                 child: Padding(
//                   padding:
//                       EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
//                   child: Text(
//                     "اضافة ",
//                     textDirection: TextDirection.ltr,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 15.0,
//                       decoration: TextDecoration.none,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                 ),
//                 color: CupertinoColors.destructiveRed,
//                 disabledColor: Colors.grey,
//                 shape: new RoundedRectangleBorder(
//                     borderRadius: new BorderRadius.circular(20.0)),
//                 onPressed: (){
//                   print(_locationcontroller);
//                   // addData(_controller.text);
//                   // Navigator.pop(context);
//                 },
//               ),
//             ),


//              Container(
//                padding: EdgeInsets.only(left: 100,right: 100,top:10 ),
//                child: OutlineButton(
//                 onPressed: (){
//                   Navigator.pop(context);
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Icon(
//                       Icons.forward
//                     ),
//                     Text("رجوع")
//                   ],
                
//             ),
//             ),
//              )
//           ],
//         ),
//       ),
      // body: Container(
      //   child: Stack(
      //     children: <Widget>[
      //       ///////////  background///////////
      //       new Container(
      //         decoration: new BoxDecoration(
      //           color: CupertinoColors.lightBackgroundGray
      //         ),
      //       ),

      //       Positioned(
      //         child: Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: <Widget>[
      //               Card(
      //                 elevation: 4.0,
      //                 color: Colors.white,
      //                 margin: EdgeInsets.only(left: 20, right: 20),
      //                 shape: RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.circular(15)),
      //                 child: Padding(
      //                   padding: const EdgeInsets.all(10.0),
      //                   child: Column(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: <Widget>[
      //                       /////////////  Email//////////////

      //                       TextField(
      //                         textAlign: TextAlign.right,
                              
      //                         style: TextStyle(color: Color(0xFF000000)),
      //                         controller: _numPhonecontroller,
      //                         cursorColor: Color(0xFF9b9b9b),
      //                         keyboardType: TextInputType.number,
      //                         decoration: InputDecoration(
                                
      //                           prefixIcon: Icon(
      //                             Icons.phone,
      //                             color: Colors.grey,
      //                           ),
      //                           hintText: "رقم الهاتف",
      //                           hintStyle: TextStyle(
      //                               color: Color(0xFF9b9b9b),
      //                               fontSize: 15,
      //                               fontWeight: FontWeight.normal),
      //                         ),
      //                       ),

      //                       /////////////// password////////////////////

      //                       TextField(
      //                         textAlign: TextAlign.right,
      //                         style: TextStyle(color: Color(0xFF000000)),
      //                         cursorColor: Color(0xFF9b9b9b),
      //                         controller: _locationcontroller,
      //                         keyboardType: TextInputType.text,
      //                         // obscureText: true,
      //                         decoration: InputDecoration(
      //                           prefixIcon: Icon(
      //                             Icons.map,
      //                             color: Colors.grey,
      //                           ),
      //                           hintText: "العنوان",
      //                           hintStyle: TextStyle(
      //                               color: Color(0xFF9b9b9b),
      //                               fontSize: 15,
      //                               fontWeight: FontWeight.normal),
      //                         ),
      //                       ),
      //                       /////////////  LogIn Botton///////////////////
      //                       Padding(
      //                         padding: const EdgeInsets.all(10.0),
      //                         child: RaisedButton(
      //                           child: Padding(
      //                             padding: EdgeInsets.only(
      //                                 top: 8, bottom: 8, left: 10, right: 10),
      //                             child: Text("انشاء البطاقة",
      //                               textDirection: TextDirection.ltr,
      //                               style: TextStyle(
      //                                 color: Colors.white,
      //                                 fontSize: 15.0,
      //                                 decoration: TextDecoration.none,
      //                                 fontWeight: FontWeight.normal,
      //                               ),
      //                             ),
      //                           ),
      //                           color: CupertinoColors.destructiveRed,
      //                           disabledColor: Colors.grey,
      //                           shape: new RoundedRectangleBorder(
      //                               borderRadius:
      //                                   new BorderRadius.circular(20.0)),
      //                           onPressed: (){
      //                               print(user_id); 
      //                               print(ser_id);
      //                               print(_numPhonecontroller.text);
      //                               print(_locationcontroller.text);
      //                             addcard.addData(
      //                               user_id: user_id,
      //                               service_id:ser_id,
      //                               numPhone: _numPhonecontroller.text.trim(),
      //                               location: _locationcontroller.text
      //                               );
      //                               Navigator.pushReplacementNamed(context, "interface");

                                  

      //                           },
                               
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),

                   

                                 
      //             ],
      //           ),
      //         ),
      //       )
      //     ],
//       //   ),
//       // ),
//     );
//   }
// }
