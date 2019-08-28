// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intro_slider/dot_animation_enum.dart';
// import 'package:intro_slider/intro_slider.dart';
// import 'package:intro_slider/slide_object.dart';
// import 'package:shared_preferences/shared_preferences.dart';


// class IntroScreen extends StatefulWidget {
//   @override
//   _IntroScreenState createState() => _IntroScreenState();
// }

// class _IntroScreenState extends State<IntroScreen> {

//     _saveintro(String newuser) async {
//     final prefs = await SharedPreferences.getInstance();
//     final key = 'intro';
//     final value = newuser;
//     prefs.setString(key, value);
//   }
// int value ;
//   readIntro() async {
//     final prefs = await SharedPreferences.getInstance();
//     final key = 'intro';
//      value = prefs.get(key) ?? 0;
//     print('read : $value');
//     if(value==0){
//       Navigator.pushNamed(context, "interface");
//     }
//   }
//   List<Slide> slides = new List();

//   @override
//   void initState() {
//     readIntro();
//     super.initState();

//     slides.add(
//       new Slide(
//         title: "حرفة",
//         description: "هل انت من مدينة الموصل ولديك حرفة وتريد الحصول على زبائن؟",
//         // pathImage: "images/photo_eraser.png",
//         backgroundColor: CupertinoColors.destructiveRed.withOpacity(0.7),
//       ),
//     );
//     slides.add(
//       new Slide(
//         title: "حرفة",
//         description: "تطبيق خدمة مجتمع يساعد من لديه حرفة معينة او عمل ويريد الحصول على زبائن جدد مجانا بدون دفع رسوم اشتراك",
//         // pathImage: "images/photo_pencil.png",
//         backgroundColor: Color(0xff203152),
//       ),
//     );
//     slides.add(
//       new Slide(
//         title: "حرفة",
//         description:
//         "كل ما عليك هو انشاء حساب من ثم انشاء بطاقتك التعريفية الخاصة بك وانتظر تواصل الناس معك عبر رقم هاتفك الخاص ",
//         // pathImage: "images/photo_ruler.png",
//         backgroundColor: CupertinoColors.activeBlue.withOpacity(0.6),
//       ),
//     );
//   }

//   void onDonePress() {
//     _saveintro("0");
//     Navigator.pushReplacementNamed(context, "interface");
//     // Do what you want
//   }

//   @override
//   Widget build(BuildContext context) {
//     return value==0?Container(color: Colors.white,):
    
//      IntroSlider(
//       nameNextBtn: "استمرار",
//       nameDoneBtn: "انهاء",
//       nameSkipBtn: "تخطي",
//       typeDotAnimation: dotSliderAnimation.DOT_MOVEMENT,
//       slides: this.slides,
//       onDonePress: this.onDonePress,
//     );
//   }
// }


