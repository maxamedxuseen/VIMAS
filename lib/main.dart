
import 'package:flutter/material.dart';

import 'package:uix/screens/splash_screen.dart';

void main() {
  runApp(IDLogin());
}

class IDLogin extends StatelessWidget {
  const IDLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: const Color(0xff111328),
        scaffoldBackgroundColor: const Color(0xff111328),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
