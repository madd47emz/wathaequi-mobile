import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wathaequi/views/3-dash.dart';
import 'package:wathaequi/views/2-login.dart';
import 'package:wathaequi/views/res/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AnimatedSplashScreen(
      splashIconSize: MediaQuery.of(context).size.width*0.5,
      nextScreen: Login(),
      splashTransition: SplashTransition.slideTransition,


      splash: Container(
        width: MediaQuery.of(context).size.width*0.5,
        height: MediaQuery.of(context).size.width*0.5,

        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Image.asset("assets/images/logo.png",width: MediaQuery.of(context).size.width*0.5,height: MediaQuery.of(context).size.width*0.5,),
        ),

        decoration: BoxDecoration(

          shape: BoxShape.circle,
          color: mainColor,

        ),
      ));
  }
}


