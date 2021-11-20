import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/honepage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController firstn = TextEditingController();
    TextEditingController password = TextEditingController();
    // TextEditingController password = TextEditingController();
    // TextEditingController repassword = TextEditingController();

    if (firstn.text == "" || password.text == "") {
      Fluttertoast.showToast(
        msg: "Both fields cant be blank",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        fontSize: 16,
      );
    }

    Future login() async {
      var url = "http://192.168.56.1/localconnect/DataBase.php";
      // ignore: unused_local_variable
      var response = await http.post(Uri.parse(url), body: {
        "username": firstn.text,
        "password": password.text,
      });
      var data = json.decode(response.body);
      if (data == "success") {
        Navigator.push(context, MaterialPageRoute(builder: (_) => Honepage()));
      } else {
        Fluttertoast.showToast(
          msg: "The user and password does not exits",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 16,
        );
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: firstn,
                  decoration: InputDecoration(
                    hintText: 'USer nane',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                TextFormField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'password',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                // TextFormField(
                //   controller: password,
                //   decoration: InputDecoration(
                //     hintText: 'Type password',
                //     enabledBorder: OutlineInputBorder(
                //       borderSide: BorderSide(
                //         color: Colors.black,
                //         width: 1,
                //       ),
                //     ),
                //   ),
                // ),
                // TextFormField(
                //   controller: repassword,
                //   decoration: InputDecoration(
                //     hintText: 'Confirn password',
                //     enabledBorder: OutlineInputBorder(
                //       borderSide: BorderSide(
                //         color: Colors.black,
                //         width: 1,
                //       ),
                //     ),
                //   ),
                // ),
                // ElevatedButton(
                //   onPressed: () {},
                //   child: Text("SignUp"),
                // )

                ElevatedButton(
                  onPressed: () {
                    login();
                  },
                  child: Text("Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
