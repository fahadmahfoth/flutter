import 'package:Herfa/user/getuser.dart';
import 'package:Herfa/user/usertoken.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'addcard.dart';
import 'addverves.dart';
import 'cards.dart';
import 'logingui.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'servece.dart';

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
        primaryColor: Colors.white,
          fontFamily: "gen01",
          cardColor:   Color(0xffBEB9C0),
          appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: Colors.red),

              textTheme: TextTheme(
                  title: TextStyle(
                      color: CupertinoColors.destructiveRed.withOpacity(0.9),
                      fontSize: 25,
                      fontFamily: "gen01"))),
          accentColor: Color(0xff16324A)),
      routes: {
        "interface": (context) => InterFace(),
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


  @override
  _InterFaceState createState() => _InterFaceState();
}

class _InterFaceState extends State<InterFace> {

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
          // leading: Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: ClipOval(child: Image.asset("assets/herfa_logo.png"),),
          // ),
          centerTitle: true,
          title: Text(
            "حرفة",
            textAlign: TextAlign.right,
          ),
          // backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        bottomNavigationBar: BottomNavyBar(
          items: [
                 BottomNavyBarItem(
       icon: Icon(Icons.menu),
       title: Text('الرئيسية'),
       activeColor: Color(0xff384064),
     ),
     BottomNavyBarItem(
         icon: Icon(Icons.person),
         title: Text('الملف الشخصي'),
         activeColor: Color(0xff24385E)
     ),
     BottomNavyBarItem(
         icon: Icon(Icons.message),
         title: Text('حول',textAlign: TextAlign.right,),
         activeColor: Color(0xff16324A)
     ),

          ],
          onItemSelected:(int index) {
            setState(() {
              _selectedPage = index;
            });
          }, 
          selectedIndex: _selectedPage,
          //         barBackgroundColor: Color(0xffB48D94),

          // onTabChangedListener: (int index) {
          //   setState(() {
          //     _selectedPage = index;
          //   });
          // },
          // inactiveIconColor: CupertinoColors.darkBackgroundGray,
          // activeIconColor: CupertinoColors.destructiveRed,
          // circleColor: CupertinoColors.white,
          // initialSelection: _selectedPage,
          // tabs: [
          //   TabData(iconData: Icons.home, title: "الرئيسية"),
          //   TabData(iconData: Icons.person, title: "الملف الشخصي"),
          //   TabData(iconData: Icons.info, title: "حول")
          // ],
        ),
        body: DoubleBackToCloseApp(
   snackBar: const SnackBar(
            content: Text('اضغط مرة ثانية للخروج',textAlign: TextAlign.right,),
          ),
  child: _pageOptions[_selectedPage]));
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
                      style: TextStyle(fontSize: 40,color: Color(0xffD7EFF7)),
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
                      style: TextStyle(fontSize: 40,color: Color(0xffD7EFF7)),
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
                            style: TextStyle(fontSize: 20,color: Color(0xff384064)),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "فهد محفوظ ",
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Color(0xff384064)),
                          ),
                          subtitle: Text("مُبرمج",
                              textAlign: TextAlign.right,
                              style: TextStyle(color: Colors.red)),
                        ),
                        ListTile(
                          title: Text(
                            "ربيع علي",
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Color(0xff384064)),
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
                            style: TextStyle(color: Color(0xff384064)),
                          ),
                          subtitle: Text("info@codeforiraq.org",

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
