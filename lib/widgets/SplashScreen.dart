import 'package:app/widgets/NavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class Screen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 6,
      navigateAfterSeconds: MyBottomNavigationBar(),
      title: Text(
        "OOGGY DOGGY",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.black),
      ),
      image: Image.asset('assets/dog-paw.png'),
      backgroundColor: Colors.purple[900],
      photoSize: 100,
      loaderColor: Colors.black,
    );
  }
}
