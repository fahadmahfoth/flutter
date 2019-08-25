import 'package:flutter/material.dart';
import 'package:herfa_test/screen/addcard.dart';
import 'package:herfa_test/screen/addverves.dart';
import 'package:herfa_test/screen/intro.dart';
import 'package:herfa_test/screen/mydrawer.dart';
import 'package:herfa_test/screen/servece.dart';
import 'package:herfa_test/user/getuser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'cards.dart';
import 'logingui.dart';
import 'package:herfa_test/user/usertoken.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        "interface": (context) => InterFace(),
        "login": (context) => LoginPage(),
        "profile": (context) => Profile(),
        "cards": (context) => Cards(),
        "intro": (context) => IntroScreen(),
        "addser":(context) => AddServ(),
         "addcard":(context) => AddPageZero(),
      },
      initialRoute: "intro",
    );
  }
}

class InterFace extends StatefulWidget {
  @override
  _InterFaceState createState() => _InterFaceState();
}

class _InterFaceState extends State<InterFace> {
  int _selectedPage = 0;

  final _pageOptions = [Serves(), Profile(),PageOne()];

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
          title: Text("حرفة"),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        endDrawer: MyDrawer(),
        bottomNavigationBar: BottomNavigationBar(
          
          backgroundColor: Colors.pink,
          currentIndex: _selectedPage,
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
          type: BottomNavigationBarType.shifting,
          selectedItemColor: CupertinoColors.destructiveRed,
          unselectedItemColor:
              CupertinoColors.darkBackgroundGray.withOpacity(0.7),
          items: [
             BottomNavigationBarItem(
                title: Text("الحرف"),
                icon: SizedBox(
                    height: 40, child: Image.asset("assets/group.png"))),

           
            BottomNavigationBarItem(
                title: Text("الملف الشخصي"),
                icon: Icon(CupertinoIcons.person),
                activeIcon: Icon(Icons.person)),

                      BottomNavigationBarItem(
                title: Text("حول"),
                icon: Icon(CupertinoIcons.info),
                activeIcon: Icon(Icons.info)),
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
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://cdn.pixabay.com/photo/2017/12/29/12/46/human-3047529_960_720.jpg"))),
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
                    style: TextStyle(fontSize: 20,color: CupertinoColors.white,shadows: [
                      BoxShadow(
                        blurRadius: 10,
                        offset: Offset(1.0, 1.0),
                        spreadRadius: 1000

                      )
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
                    style: TextStyle(fontSize: 20,color: CupertinoColors.white,shadows: [
                      BoxShadow(
                        blurRadius: 10,
                        offset: Offset(1.0, 1.0),
                        spreadRadius: 1000

                      )
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
                    style: TextStyle(fontSize: 20,color: CupertinoColors.white,shadows: [
                      BoxShadow(
                        blurRadius: 10,
                        offset: Offset(1.0, 1.0),
                        spreadRadius: 1000

                      )
                    ]),
                  ),
                ),

             
              ],
            ),
            ),
          ),
          Padding(padding: EdgeInsets.all(2),),
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
                          image: NetworkImage(
                              "https://cdn.pixabay.com/photo/2019/02/10/16/12/hammer-3987550_960_720.jpg"))),
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
                  top: 70,
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
                    style: TextStyle(fontSize: 15,color: CupertinoColors.white,shadows: [
                      BoxShadow(
                        blurRadius: 10,
                        offset: Offset(1.0, 1.0),
                        spreadRadius: 1000

                      )
                    ]),
                  ),
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
