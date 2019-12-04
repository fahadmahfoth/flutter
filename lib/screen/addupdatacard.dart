import 'package:Herfa/user/usertoken.dart';
import 'package:flutter/material.dart';

class AddUpdateCards extends StatefulWidget {
  final user_id ;
  AddUpdateCards(this.user_id);
  @override
  _AddUpdateCardsState createState() => _AddUpdateCardsState(user_id);
}

class _AddUpdateCardsState extends State<AddUpdateCards> {
   final user_id ;
   _AddUpdateCardsState(this.user_id);
  
  SignUp database = SignUp();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("الحرف"),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: FutureBuilder(
        future: database.getusercard(user_id),
        builder: (context,snapshot){
          if(snapshot.hasData){
            List jobs = snapshot.data["Jobs"];
            return Column(
                   children: <Widget>[
                     ListView.builder(
                       itemCount: jobs.length,
                       itemBuilder: (context,i){
                         return Text(jobs[i]);
                       },

                     )
                   ],
            );
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}