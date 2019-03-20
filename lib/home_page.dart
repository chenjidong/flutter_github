import 'package:flutter/material.dart';

import 'ui/home/home_screen.dart';
import 'ui/home/mine_screen.dart';

///主页
class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  List<Widget> list = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list..add(HomeScreen())..add(MineScreen());
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: list[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(
                'Home',
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text(
                'Mine',
              ))
        ],
        onTap: _onItemTapped,
        currentIndex: _currentIndex,
        fixedColor: Colors.blue,
      ),
    );
  }
}
