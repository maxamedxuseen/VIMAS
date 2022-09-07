import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:qr_flutter/qr_flutter.dart';

class show_QR_code extends StatefulWidget {
  var qr;
  show_QR_code({Key?  key, required this.qr}) : super(key: key);

  @override
  State<show_QR_code> createState() => _show_QR_codeState();
}

class _show_QR_codeState extends State<show_QR_code> {
  qrcode() async{
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    qrcode();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff111328),
        body: Column(children: [
          Expanded(
            child: Center(
              child: Container(
                color: Colors.white,
                child: QrImage(
                  data: widget.qr,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
