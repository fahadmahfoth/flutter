import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:quiver/collection.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp {
  var status;

  Future<List> loginData(String email, String password) async {
    String myUrl = "http://herfa.codeforiraq.org/api/auth/login";
     try {
        await http.post(myUrl,
        body: {
         "email": "$email", "password": "$password"}
          ).then((response){
                status = response.statusCode == HttpStatus.ok;
                
var data = json.decode(response.body);
 print(data["access_token"]);
_save(data["access_token"]);
     

          });
    } catch (e) {
      print(e);
      status = false;
    }
  }

 registerData(String name, String email, String password) async {
    String myUrl = "http://herfa.codeforiraq.org/api/auth/signup";
   
    try {
        await http.post(myUrl,
        body: {
          "name": "$name", "email": "$email", "password": "$password"}
          ).then((response){
            print(response.statusCode);
                status = response.statusCode == HttpStatus.created;

var data = json.decode(response.body);
 print(data);
_save(data["token"]);
     

          });
    } catch (e) {
      print(e);
      status = false;
    }
  }

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
  }

  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print('read : $value');
  }
   _savep(bool token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'p';
    final value = token;
    prefs.setBool(key, value);
  }

  Future getServ() async {
    try {
      final response =
          await http.get("http://herfa.codeforiraq.org/api/auth/jobs");

      var result = jsonDecode(response.body)["data"];
      //  print(result);

      return result;
    } catch (e) {
      print("Error Download Data .. SOON");
    }
  }

  Future getCard(String job_name) async {
    try {
      final response = await http.get(
          "http://herfa.codeforiraq.org/api/auth/cards?s=$job_name",
          headers: {});

      if (response.statusCode == HttpStatus.ok) {
        var result = jsonDecode(response.body);
        //  print(result);
        return result["data"];
      }
    } catch (e) {
      print("Error Download Data .. SOON");
    }
  }
  

  void addCardData(
      {int user_id, int service_id, String numPhone, String location}) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? null;

    String myUrl = "http://herfa.codeforiraq.org/api/auth/cards";
    try{
      print(value.toString());
       http.post(myUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }, body: {
      
      "job_id": "$service_id",
      "phone": "$numPhone",
      "location": "$location",
    }).then((response) {
      print(response.statusCode.toString()+" "+response.body.toString());
      if(response.statusCode == HttpStatus.ok){
        _savep(true);
      }else{
        _savep(false);
      }
     
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });

    }catch (e){
      print(e.toString());

    }
   
  }


  void updateCardData(
      {int keys,
        
        int serviceId,
        String numPhone,
        String location}) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? null;
print(keys.toString());
    String myUrl = "http://herfa.codeforiraq.org/api/auth/cards/$keys";
try{
      print(value.toString());
       http.put(myUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }, body: {
      
      "job_id": "$serviceId",
      "phone": "$numPhone",
      "location": "$location",
    }).then((response) {
      print(response.statusCode.toString()+" "+response.body.toString());
   
     
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });

    }catch (e){
      print(e.toString());

    }
  }

  Future getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    try {
      final response = await http
          .get("http://herfa.codeforiraq.org/api/auth/user", headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $value'
      });

            // print(response.body);
        var result = jsonDecode(response.body);
//        print(result["data"]);
        return result["data"];

    } catch (e) {
      print("Error Download Data .. SOON");
    }

    
  }

  Future getusercard(user_id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    try {
      final response = await http
          .get("http://herfa.codeforiraq.org/api/auth/cards/$user_id", headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $value'
      });

      if (response.statusCode == HttpStatus.ok) {
        var result = jsonDecode(response.body);
        print(result);
        return result["data"];
      }
    } catch (e) {
      print("Error Download Data .. SOON");
    }
  }
}
