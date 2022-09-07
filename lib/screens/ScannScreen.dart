import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:http/http.dart';
import 'package:uix/screens/Home.dart';

class takeScann extends StatefulWidget {
  const takeScann({Key? key}) : super(key: key);

  @override
  State<takeScann> createState() => _takeScannState();
}

class _takeScannState extends State<takeScann> {
  String txtTitle = "";
  String txtDescription = "";

  Future<void> _showMyDialog(String titel, String description) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("${txtTitle}"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  "${txtDescription}",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String _scanner = "";
  final url = "https://somalibits.com/iLabVID/api.php";

  var person_image = "";
  var person_name = "";
  var person_id = "";
  var section = "";
  var issue_date = "";
  var exp_date = "";
  var person_status = "";
  var Person_pass = "";

  var _data = [];
  void gatdate() async {
    try {
      final response = await get((Uri.parse(url)));
      final datalist = jsonDecode(response.body) as List;
      setState(() {
        _data = datalist;
      });
      // nest();
    } catch (err) {}
  }

  void nest(String The_ID) {
    for (int i = 0; i < _data.length; i++) {
      final name = _data[i];
      if (name["ID_no"] == "${The_ID}") {
        final Member = _data[i];
        person_image = Member["image"];
        person_name = Member["name"];
        person_id = Member["ID_no"];
        section = Member["section"];
        issue_date = Member["issue_date"];
        exp_date = Member["exp_date"];
        person_status = Member["mem_status"];
        Person_pass = Member["password"];

        if ("${The_ID}" == "${person_id}") {
          if ("${person_status}" == "Active") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return MyApp(id: The_ID);
                },
              ),
            );
          } else {
            txtTitle = "In active Student";
            txtDescription = "This student Needs to be Activated!";
            _showMyDialog(txtTitle, txtDescription);
            break;
          }
        } else {
          txtTitle = "Unregistred Student";
        txtDescription = "This student does not exist! ";
        _showMyDialog(txtTitle, txtDescription);
        break;
        }
      } 
    }
  }

  void _goHome(String scannedID) {
    nest(scannedID);
  }

  void _scan() async {
    await FlutterBarcodeScanner.scanBarcode(
            "#000000", "Cancle", true, ScanMode.BARCODE)
        .then((value) => setState(() => _goHome(value)));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scan();
    // _goHome();
  }

  @override
  Widget build(BuildContext context) {
    gatdate();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff111328),
        body: Center(
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _scan(),
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 70),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 54,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            (new Color(0xffF5591F)),
                            new Color(0xffF2861E)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight),
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[200],
                      boxShadow: [
                        // BoxShadow(
                        //     offset: Offset(0, 10),
                        //     blurRadius: 50,
                        //     color: Color(0xffEEEEEE)),
                      ],
                    ),
                    child: Text(
                      "Scan now",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    _scanner,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
