import 'package:flutter/material.dart';
import 'package:flutter_github/common/config/config.dart';
import 'package:flutter_github/common/util/shared_preferences_util.dart';
import 'package:flutter_github/view/home_page_screen.dart';
import 'package:flutter_github/view/intro_slider_screen.dart';

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
        bool isFirst = await SharedPreferencesUtil.get(Config.FIRST_LAUNCHER);
        if (isFirst ?? false) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => MyHomePage(title: 'Home')),
              (route) => route == null);
        } else {
          SharedPreferencesUtil.saveBool(Config.FIRST_LAUNCHER, true);
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
