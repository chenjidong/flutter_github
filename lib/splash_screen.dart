import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page_screen.dart';
import 'intro_slider_screen.dart';

///启动页
///
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    _animation.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        bool isFirst = sharedPreferences.getBool("first_launcher");
        if (isFirst != null || isFirst) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => MyHomePage(title: 'Home')),
              (route) => route == null);
        } else {
          sharedPreferences.setBool("first_launcher", true);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => SliderScreen()),
              (route) => route == null);
        }
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new FadeTransition(
      opacity: _animation,
      child: new Image.asset('assets/photo.jpg', scale: 2.0, fit: BoxFit.cover),
    );
  }
}
