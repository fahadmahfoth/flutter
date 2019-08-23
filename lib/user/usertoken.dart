import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp {
  var status;



  Future<List> loginData(String email, String password) async {
    String myUrl = "http://herfa.codeforiraq.org/api/login";
    final response = await http
        .post(myUrl, body: {"email": "$email", "password": "$password"});
    status = response.body.contains('error');

    var data = json.decode(response.body);
     _save(data["data"]["token"]);
    if (status) {
      print('data : ${data["error"]}');
    } else {
      print('data : ${data["data"]["token"]}');
      _save(data["data"]["token"]);
    }
  }

  


  Future<List> registerData(String name,String email, String password) async {
    String myUrl = "http://herfa.codeforiraq.org/api/registerUser";
    final response = await http
        .post(myUrl, body: {"name":"$name","email": "$email", "password": "$password"});
    status = response.body.contains('error');

    var data = json.decode(response.body);
    print('data : ${data["data"]["token"]}');
    _save(data["data"]["token"]);
    if (status) {
      print('data : ${data["error"]}');
    } else {
      print('data : ${data["token"]}');
      _save(data["data"]["token"]);
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


   Future getServ() async {
    try {
      final response =
          await http.get("http://herfa.codeforiraq.org/api/services/");

      var result = jsonDecode(response.body)["data"]["data"];
      //  print(result);
    
      
              return result;

    

    } catch (e) {
      print("Error Download Data .. SOON");
    }

  }


  Future getCard(String job_name) async {
    try {
      final response = await http.get(
          "http://herfa.codeforiraq.org/api/cards?s=$job_name",
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
      {int user_id,
      int service_id,
      String numPhone,
      String location}) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? null;

    String myUrl =
        "http://herfa.codeforiraq.org/api/cards";
    http.post(myUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }, body: {
      "user_id": "$user_id",
      "service_id": "$service_id",
      "numPhone": "$numPhone",
      "location": "$location",
    }).then((response) {
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }
    Future getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    try {
      final response = await http
          .get("http://herfa.codeforiraq.org/api/getUserinfo", headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $value'
      });

      if (response.statusCode == HttpStatus.ok) {
        var result = jsonDecode(response.body);
        // print(result);
        return result["data"];
      }
    } catch (e) {
      print("Error Download Data .. SOON");
    }
  }


      Future getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    try {
      final response = await http
          .get("http://herfa.codeforiraq.org/api/getUserinfo", headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $value'
      });

      if (response.statusCode == HttpStatus.ok) {
        var result = jsonDecode(response.body);
        // print(result);
        final user = User(
          key: result["data"]["key"],
          name:result["data"]["name"],
          email:result["data"]["email"],
          emailVerifiedAt:result["data"]["email_verified_at"],
          createdAt:result["data"]["created_at"],
          updatedAt:result["data"]["updated_at"],);
          print(user.key);
        return user ;
      }
    } catch (e) {
      print("Error Download Data .. SOON");
    }
  }


}




class User {
    int key;
    String name;
    String email;
    dynamic emailVerifiedAt;
    DateTime createdAt;
    DateTime updatedAt;

    User({
        this.key,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
    });
}
