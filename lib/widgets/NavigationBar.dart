import 'package:app/pages/contactsPage.dart';
import 'package:app/pages/detectPage.dart';
import 'package:app/pages/helpPage.dart';
import 'package:app/pages/homePage.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePage(),
    DetectPage(),
    ContactPage(),
    HelpPage()
  ];
  var _pageController = PageController();

  void onTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(_currentIndex,
          duration: Duration(microseconds: 200), curve: Curves.easeIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        title: Image.asset(
          'assets/dog-paw.png',
          width: 40,
          height: 40,
        ),
        centerTitle: true,
      ),
      body: PageView(
        children: _children,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        controller: _pageController,
      ),
      bottomNavigationBar: BottomNavyBar(
        onItemSelected: onTapped,
        selectedIndex: _currentIndex,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
              activeColor: Colors.purple[900],
              inactiveColor: Colors.black),
          BottomNavyBarItem(
              icon: Icon(Icons.center_focus_strong_sharp),
              title: Text("Detect"),
              activeColor: Colors.purple[900],
              inactiveColor: Colors.black),
          BottomNavyBarItem(
              icon: Icon(Icons.contact_page),
              title: Text("Contact"),
              activeColor: Colors.purple[900],
              inactiveColor: Colors.black),
          BottomNavyBarItem(
              icon: Icon(Icons.help),
              title: Text("Help"),
              activeColor: Colors.purple[900],
              inactiveColor: Colors.black),
        ],
      ),
    );
  }
}
