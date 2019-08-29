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
    try {
      _save(data["data"]["token"]);
      if (status) {
        print('data : ${data["error"]}');
      } else {
        print('data : ${data["data"]["token"]}');
        _save(data["data"]["token"]);
      }
    } catch (e) {
      print(e);
      status = false;
    }
  }

  Future<List> registerData(String name, String email, String password) async {
    String myUrl = "http://herfa.codeforiraq.org/api/registerUser";
    final response = await http.post(myUrl,
        body: {"name": "$name", "email": "$email", "password": "$password"});
    status = response.body.contains('error');

    var data = json.decode(response.body);
    try {
      _save(data["data"]["token"]);
    } catch (e) {
      print(e);
      status = false;
    }

    // if (status) {
    //   print('data : ${data["error"]}');
    // } else {
    //   print('data : ${data["token"]}');
    //   _save(data["data"]["token"]);
    // }
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
          await http.get("http://herfa.codeforiraq.org/public/api/services/");

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
      {int user_id, int service_id, String numPhone, String location}) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? null;

    String myUrl = "http://herfa.codeforiraq.org/api/cards";
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

  void updateCardData(
      {int keys,
      int user_id,
      int service_id,
      String numPhone,
      String location}) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? null;

    String myUrl = "http://herfa.codeforiraq.org/api/cards/$user_id";
    http.put(myUrl, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $value'
    }, body: {
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

  Future getusercard(int user_id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    try {
      final response = await http
          .get("http://herfa.codeforiraq.org/api/cards/$user_id", headers: {
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
