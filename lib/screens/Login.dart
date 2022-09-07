import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:uix/main.dart';
import 'Home.dart';

import 'package:http/http.dart';
import 'dart:convert';

import 'ScannScreen.dart';

class ILabLogin extends StatefulWidget {
  const ILabLogin({Key? key}) : super(key: key);

  @override
  _ILabLoginState createState() => _ILabLoginState();
}

class _ILabLoginState extends State<ILabLogin> {
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
                Text("${txtDescription}."),
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

  void _senddata(BuildContext context) {
    String _id = The_ID.text;
    print(_id);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return MyApp(id: _id);
        },
      ),
    );
  }

  TextEditingController The_ID = new TextEditingController();
  TextEditingController The_pass = new TextEditingController();

  final staff_url = "https://bytesotech.com/api/staffAPI.php";
  var _staff_data = [];

  void getStaffInfo() async {
    try {
      final responseS = await get((Uri.parse(staff_url)));
      final datalistStaff = jsonDecode(responseS.body) as List;
      setState(() {
        _staff_data = datalistStaff;
      });
    } catch (err) {}
  }

  void nestStaff() {
    for (int i = 0; i < _staff_data.length; i++) {
      final Staff = _staff_data[i];
      if (Staff["ID_no"] == "${The_ID.text}") {
        final n = _staff_data[i];
        person_name = n["staff_name"];
        person_id = n["ID_no"];

        person_status = n["staff_status"];
        Person_pass = n["pass"];

        if ("${The_ID.text}" == "${person_id}" &&
            "${The_pass.text}" == "${Person_pass}") {
          if ("${person_status}" == "Active") {
            print("Yes you are in");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return takeScann();
                },
              ),
            );
          } else {
            txtTitle = "In active User";
            txtDescription =
                "Please contact Your Admin for Activation \n Thank You!";
            _showMyDialog(txtTitle, txtDescription);
          }
        } else {
          txtTitle = "In correct details";
          txtDescription =
              "Your ID or password is in valid \n please try again ";
          _showMyDialog(txtTitle, txtDescription);
        }
      }
    }
  }

  final url = "https://bytesotech.com/api/membersAPI.php";

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
        getStaffInfo();
      });
      // nest();
    } catch (err) {}
  }

  void nest() {
    for (int i = 0; i < _data.length; i++) {
      final name = _data[i];
      if (name["ID_no"] == "${The_ID.text}") {
        final n = _data[i];
        person_image = n["image"];
        person_name = n["name"];
        person_id = n["ID_no"];
        section = n["section"];
        issue_date = n["issue_date"];
        exp_date = n["exp_date"];
        person_status = n["mem_status"];
        Person_pass = n["password"];

        if ("${The_ID.text}" == "${person_id}" &&
            "${The_pass.text}" == "${Person_pass}") {
          if ("${person_status}" == "Active") {
            _senddata(context);
          } else {
            txtTitle = "In active User";
            txtDescription =
                "Please contact Your Admin for Activation \n Thank You!";
            _showMyDialog(txtTitle, txtDescription);
          }
        } else {
          txtTitle = "In correct details";
          txtDescription =
              "Your ID or password in in valid \n please try again ";
          _showMyDialog(txtTitle, txtDescription);
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gatdate();
  }

  @override
  Widget build(BuildContext context) {
    if (_data.isNotEmpty || _staff_data.isNotEmpty) {
      print(_data);
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 218, 150, 3),
        body: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFF010E27),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 28.0, fontWeight: FontWeight.bold),
                    ),
                    //),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      height: 54,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey,
                        boxShadow: [
                          // BoxShadow(
                          //     offset: Offset(0, 20),
                          //     blurRadius: 100,
                          //     color: Color(0xffEEEEEE)),
                        ],
                      ),
                      child: TextField(
                        controller: The_ID,
                        cursorColor: Color.fromARGB(255, 218, 150, 3),
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.perm_identity,
                            color: Color.fromARGB(255, 218, 150, 3),
                          ),
                          hintText: "Your ID ",
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                      padding: EdgeInsets.only(left: 20, right: 20),
                      height: 54,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey,
                      ),
                      child: TextField(
                        controller: The_pass,
                        cursorColor: Color.fromARGB(255, 218, 150, 3),
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: Color.fromARGB(255, 218, 150, 3),
                          ),
                          hintText: "Password",
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Write Click Listener Code Here.
                        var textID = int.parse(The_ID.text);
                        if (textID > 100099) {
                          nest();
                        } else {
                          nestStaff();
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 40),
                        padding: EdgeInsets.only(left: 20, right: 20),
                        height: 54,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                (Color.fromARGB(255, 218, 150, 3)),
                                Color.fromARGB(255, 218, 150, 3)
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey[200],
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 5),
                                blurRadius: 20,
                                color: Color.fromARGB(255, 15, 5, 107)),
                          ],
                        ),
                        child: Text(
                          "LOGIN",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Center(child: CircularProgressIndicator());
  }
}
