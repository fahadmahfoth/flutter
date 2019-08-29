import 'package:flutter/material.dart';
import 'package:herfa_test/screen/addcard.dart';
import 'package:herfa_test/screen/addverves.dart';
import 'package:herfa_test/screen/servece.dart';
import 'package:herfa_test/user/getuser.dart';
import 'package:flutter/cupertino.dart';
import 'cards.dart';
import 'logingui.dart';
import 'package:herfa_test/user/usertoken.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool themdata = false;

  SignUp userdata = SignUp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: "gen01",
          cardColor: CupertinoColors.extraLightBackgroundGray,
          canvasColor: CupertinoColors.white,
          appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: CupertinoColors.destructiveRed),
              textTheme: TextTheme(
                  title: TextStyle(
                      color: CupertinoColors.destructiveRed.withOpacity(0.9),
                      fontSize: 25,
                      fontFamily: "gen01"))),
          accentColor: CupertinoColors.destructiveRed),
      routes: {
        "interface": (context) => InterFace(themdata),
        "login": (context) => LoginPage(),
        "profile": (context) => Profile(),
        "cards": (context) => Cards(),
        "addser": (context) => AddServ(),
        "addcard": (context) => AddPageZero(),
      },
      initialRoute: "interface",
    );
  }
}

class InterFace extends StatefulWidget {
  InterFace(this.themdata);
  bool themdata = false;

  @override
  _InterFaceState createState() => _InterFaceState(themdata);
}

class _InterFaceState extends State<InterFace> {
  _InterFaceState(this.themdata);
  bool themdata;

  int _selectedPage = 0;

  final _pageOptions = [Serves(), Profile(), PageOne()];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "حرفة",
            textAlign: TextAlign.right,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        bottomNavigationBar: FancyBottomNavigation(
          onTabChangedListener: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
          inactiveIconColor: CupertinoColors.darkBackgroundGray,
          activeIconColor: CupertinoColors.destructiveRed,
          circleColor: CupertinoColors.white,
          initialSelection: _selectedPage,
          tabs: [
            TabData(iconData: Icons.home, title: "الرئيسية"),
            TabData(iconData: Icons.person, title: "الملف الشخصي"),
            TabData(iconData: Icons.info, title: "حول")
          ],
        ),
        body: _pageOptions[_selectedPage]);
  }
}

class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Card(
            elevation: 10,
            child: Container(
              height: MediaQuery.of(context).size.height - 400,
              width: MediaQuery.of(context).size.width - 100,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/bb.jpg"))),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Text(
                      "حرفة",
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                  Positioned(
                    top: 70,
                    right: 10,
                    child: Text(
                      """التطبيق يتيح للمستخدم ان يبحث 
                  عن الحرفي الذي يريده 
                  
                  """,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 15,
                          color: CupertinoColors.white,
                          shadows: [
                            BoxShadow(
                                blurRadius: 10,
                                offset: Offset(1.0, 1.0),
                                spreadRadius: 1000)
                          ]),
                    ),
                  ),
                  Positioned(
                    top: 160,
                    right: 10,
                    child: Text(
                      """عن طريق المعلومات التي يضيفها
                  الحرفي نفسه
                  
                  """,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 15,
                          color: CupertinoColors.white,
                          shadows: [
                            BoxShadow(
                                blurRadius: 10,
                                offset: Offset(1.0, 1.0),
                                spreadRadius: 1000)
                          ]),
                    ),
                  ),
                  Positioned(
                    top: 260,
                    right: 10,
                    child: Text(
                      """تم برمجة التطبيق من قبل
                    اعضاء مبادرة البرمجة
                    من اجل العراق
                    
                  
                  """,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 15,
                          color: CupertinoColors.white,
                          shadows: [
                            BoxShadow(
                                blurRadius: 10,
                                offset: Offset(1.0, 1.0),
                                spreadRadius: 1000)
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(2),
          ),
          Card(
            elevation: 10,
            child: Container(
              height: MediaQuery.of(context).size.height - 400,
              width: MediaQuery.of(context).size.width - 100,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/aa.jpg"))),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Text(
                      "Code for Iraq",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    right: 10,
                    child: Text(
                      """وهي مبادرة إنسانية غير ربحية
                    تهدف الى خدمة المجتمع عن طريق البرمجة
                     مبادرة تعليمية حقيقية ترعى المهتمين
                     بتعلم تصميم وبرمجة تطبيقات الهاتف الجوال
                      ومواقع الانترنت وبرامج الحاسوب والشبكات
                      والاتصالات ونظم تشغيل الحاسوب
                       باستخدام التقنيات مفتوحة المصدر 
                       كما توفر لهم جميع الدروس
                       التعليمية اللازمة وبشكل مجاني تماماً

                  
                  """,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 12,
                          color: CupertinoColors.white,
                          shadows: [
                            BoxShadow(
                                blurRadius: 10,
                                offset: Offset(1.0, 1.0),
                                spreadRadius: 1000)
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 10,
            child: Container(
              height: MediaQuery.of(context).size.height - 400,
              width: MediaQuery.of(context).size.width - 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    height: 150,
                    width: 150,
                    child: ClipOval(
                      child: Image.asset("assets/codeforiraq.png"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Text(
                            "المطورين",
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "فهد محفوظ ",
                            textAlign: TextAlign.right,
                          ),
                          subtitle: Text("مُبرمج",
                              textAlign: TextAlign.right,
                              style: TextStyle(color: Colors.red)),
                        ),
                        ListTile(
                          title: Text(
                            "ربيع علي",
                            textAlign: TextAlign.right,
                          ),
                          subtitle: Text("مُبرمج",
                              textAlign: TextAlign.right,
                              style: TextStyle(color: Colors.red)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Divider(),
                        ),
                        ListTile(
                          title: Text(
                            "Code for Iraq",
                            textAlign: TextAlign.center,
                          ),
                          subtitle: Text("info@codeforiraq@org",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 23,
                                  color: Colors.red)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 50),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
