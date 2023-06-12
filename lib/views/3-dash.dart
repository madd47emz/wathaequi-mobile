import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:wathaequi/views/3-dash.dart';
import 'package:wathaequi/views/5-feeds.dart';
import 'package:wathaequi/views/6-find.dart';
import 'package:wathaequi/views/4-home.dart';
import 'package:wathaequi/views/res/colors.dart';

class Dash extends StatefulWidget {
  const Dash({Key? key}) : super(key: key);

  @override
  State<Dash> createState() => _DashState();
}

class _DashState extends State<Dash> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _current,
        children: [
          Home(),
          Feeds(),
          Find(),
        ],
      ),
      backgroundColor: Colors.redAccent,
      bottomNavigationBar: GNav(

          iconSize: 20,
          textSize: 15,
          selectedIndex: _current,
          onTabChange: (index) => setState(() {
                _current = index;
              }),
          backgroundColor: mainColor,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.white.withOpacity(0.25),
          duration: Duration(milliseconds: 300),
          tabs: [
            GButton(

              icon: Icons.home,
              text: "Home",
            ),
            GButton(icon: Icons.report_problem, text: "Report"),
            GButton(icon: Icons.location_pin, text: "Find"),
          ]),
    );
  }
}
