import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uix/screens/ShowQR.dart';

class MyApp extends StatefulWidget {
  var id;

  MyApp({Key? mykey, required this.id}) : super(key: mykey);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  final url = "https://bytesotech.com/apis/membersAPI.php";

  var person_image = "";
  var person_name = "";
  var person_id = "";
  var section = "";
  var issue_date = "";
  var exp_date = "";

  var _data = [];
  Future gatdate() async {
    try {
      final response = await get((Uri.parse(url)));
      final datalist = jsonDecode(response.body) as List;
      setState(() {
        _data = datalist;
      });
      nest();
    } catch (err) {}
  }

  screenshot() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  void nest() {
    for (int i = 0; i < _data.length; i++) {
      final name = _data[i];
      if (name["ID_no"] == "${widget.id}") {
        final n = _data[i];

        person_image = n["image"];
        person_name = n["name"];
        person_id = n["ID_no"];
        section = n["section"];
        issue_date = n["issue_date"];
        exp_date = n["exp_date"];
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gatdate();
    screenshot();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'SIMAD ILAB ID CARD',
            style: TextStyle(color: Color(0xff001848)),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 218, 150, 3),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return show_QR_code(qr: person_id);
                    },
                  ),
                );
              },
              icon: Icon(Icons.qr_code_2_rounded),
              iconSize: 35.0,
              color: Color(0xff111328),
            )
          ],
        ),
        backgroundColor: Color(0xff001848),
        body: FutureBuilder(
          future: gatdate(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (person_name != "") {
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage("${person_image}"),
                      radius: 100,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: Color.fromARGB(255, 218, 150, 3),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${person_name}",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_to_home_screen,
                          color: Color.fromARGB(255, 218, 150, 3),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "ID no : ${person_id}",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.class_,
                          color: Color.fromARGB(255, 218, 150, 3),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Section : ${section}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.date_range,
                          color: Color.fromARGB(255, 218, 150, 3),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Issue :",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 80,
                        ),
                        Icon(
                          Icons.date_range,
                          color: Color.fromARGB(255, 218, 150, 3),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Exp : ",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "${issue_date}",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 70,
                        ),
                        Text(
                          "${exp_date}",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30.0),
                            topLeft: Radius.circular(30.0),
                          )),
                      child: Center(
                        child: Text(
                          "ACTIVE CARD",
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 14, 163, 19)),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
