import 'package:flutter/material.dart';
import 'package:flutter1/ui/home/home_page.dart';
import 'package:flutter1/ui/login/login.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import '../../common/user_manager.dart';

class Welcome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return WelcomeWidget();
  }
}

class WelcomeWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return WelcomeState();
  }
}

class WelcomeState extends State<WelcomeWidget>{

  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();
    slides.add(
      Slide(
        maxLineTitle: 2,
        title: "WELCOME TO \nEVERNOTE",
        description: "Allow miles wound place the leave had. To sitting subject no improve studied limited",
        backgroundColor: Color(0xfff5a623),
      )
    );

    slides.add(
        Slide(
          maxLineTitle: 2,
          title: "WELCOME TO \nEVERNOTE",
          description: "Allow miles wound place the leave had. To sitting subject no improve studied limited",
          backgroundColor: Color(0xff9932CC),
        )
    );

    slides.add(
        Slide(
          maxLineTitle: 2,
          title: "WELCOME TO \nEVERNOTE",
          description: "Allow miles wound place the leave had. To sitting subject no improve studied limited",
          backgroundColor: Color(0xff203152),
        )
    );
    UserManager.getInstance().setWelcome();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroSlider(
        slides: slides,
        onDonePress: enterPage,
        onSkipPress: enterPage,
      ),
    );
  }

  void enterPage() async{
    String loginedUser =await UserManager.getInstance().hasLogined();
    if(loginedUser != null && loginedUser.isNotEmpty){
      await UserManager.getInstance().initUser(loginedUser);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => NoteList()), (route)=>false);
    }else{
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Login()), (route)=>false);
    }
  }
}