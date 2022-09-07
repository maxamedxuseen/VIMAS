import 'dart:async';

import 'package:adobe_xd/pinned.dart';
import 'package:flutter/material.dart';
import 'Login.dart';

void main() {
  runApp(SplashScreen());
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = Duration(seconds: 4);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ILabLogin()));
  }

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Pinned.fromPins(
            Pin(size: 428.0, start: -213.9),
            Pin(size: 183.0, start: -91.2),
            child: Transform.rotate(
              angle: 1.568,
              child:  Container(
                decoration: BoxDecoration(
                  color: const Color(0xfff09308),
                  borderRadius:
                      BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                ),
              ),
            ),
          ),
          Pinned.fromPins(
            Pin(start: 0.0, end: 0.0),
            Pin(size: 183.0, end: -90.0),
            child:
                // Adobe XD layer: 'Ellipse 2' (shape)
                Container(
              decoration: BoxDecoration(
                color: const Color(0xfff09308),
                borderRadius:
                    BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
              ),
            ),
          ),
          Center(
            child: Container(
              child: Image.asset("assets/images/SimadILab.png"),
            ),
          )
        ],
      ),
    );
  }
}
