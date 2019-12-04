
import 'package:Herfa/screen/addverves.dart';
import 'package:Herfa/user/usertoken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class AddS extends StatefulWidget {
  @override
  _ServesState createState() => _ServesState();
}

class _ServesState extends State<AddS> {
  String uri = "";
  SignUp gser = SignUp();

  @override
  void initState() {
    super.initState();
    gser.getServ();
  }

     _savep(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'p';
    final value = token;
    prefs.setString(key, value);
  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      body: FutureBuilder(
        future: gser.getServ(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                  appBar: AppBar(
        leading:  IconButton(
          onPressed: (){
             setState(() {
              _savep(null);
            });
            Navigator.pushReplacementNamed(context, "interface");
          },
            icon: Icon(Icons.keyboard_arrow_right),
          ),
        title: Text("اختر حرفتك"),
        centerTitle: true,
      ),
                backgroundColor: Colors.transparent,
                body: Center(
                  child: new Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width - 20,
                      child: Column(
                        children: <Widget>[
                
                          _search_in_body(),
                          Expanded(
                            child: ListView.builder(

                              itemCount: snapshot.toString().contains(uri)?snapshot.data.length:0,
                              itemBuilder: (BuildContext context, int i) {
                                var mydata = snapshot.data[i];

                                return mydata["name"].toString().contains(uri)? Container(
                                  child: NewServ(
                                        kays:mydata["id"],
                                      job_name: mydata["name"]),
                                ):Padding(padding: EdgeInsets.all(0),);
                              },
                  
                            ),
                          ),
                        ],
                      )),
                ),
      
                );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
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
  NewServ({this.job_name,this.kays});
  var job_name;
  var kays ;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 5,
      padding: EdgeInsets.all(5),
      child: Container(
        // color: Color(0xffBEB9C0),
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
              return AddCard(kays);
            }));
          },
        ),
      ),
    );
  }
}


class AddCard extends StatefulWidget {
  AddCard(this.job);
  final job ;
  @override
  _AddCardState createState() => _AddCardState(this.job);
}

class _AddCardState extends State<AddCard> {

  SignUp database = SignUp();
  TextEditingController _controller = new TextEditingController();
  TextEditingController _phcontroller = new TextEditingController();
    _AddCardState(this.job);
  final job ;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text("اكمل البيانات"),
         centerTitle: true,
       ),
       body:FutureBuilder(
         future: database.getUser(),
         builder: (context,snapshot){
           if (snapshot.hasData) {
            int user_id =snapshot.data["key"];
             return Container(
               child: ListView(
                 children: <Widget>[
        Padding(
                padding: const EdgeInsets.fromLTRB(50, 50, 50, 10),
                child: TextField(
                  controller: _phcontroller,
                  textAlign: TextAlign.right,
                  maxLength: 14,
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
                    
                   print(job.toString());



                    database.addCardData(
                         user_id: user_id,
                        service_id: job,
                        numPhone: _phcontroller.text.trim(),
                        location: _controller.text);
                    Navigator.pushReplacementNamed(context, "interface");
                    // _saveadd("card added");
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
              ),

                 ],
               ),
             );
             
           } else {
             return Center(child: CircularProgressIndicator(),);
           }
         },
       )
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
              'الحد الاقصى لعدد الحرف هو 4',
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