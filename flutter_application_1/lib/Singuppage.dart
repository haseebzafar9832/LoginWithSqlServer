import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/honepage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class MyHomePageS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController enail = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController reppassword = TextEditingController();
    // TextEditingController repassword = TextEditingController();
    Future login() async {
      if (enail.text == "" || password.text == "" || reppassword.text == "") {
        Fluttertoast.showToast(
          msg: "Both fields cant be blank",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          fontSize: 16,
        );
      } else {
        if (password.text == reppassword.text) {
          var url = "http://192.168.56.1/localconnect/Register.php";
          // ignore: unused_local_variable
          var response = await http.post(Uri.parse(url), body: {
            "username": enail.text,
            "password": password.text,
          });
          var data = json.decode(response.body);
          if (data == "success") {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => Honepage()));
          } else {
            Fluttertoast.showToast(
              msg: "The user and password does not exits",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              fontSize: 16,
            );
          }
        } else {
          Fluttertoast.showToast(
            msg: "Both paswords doest not exist",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            fontSize: 16,
          );
        }
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
                  controller: enail,
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
                TextFormField(
                  controller: reppassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Type password',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                  ),
                ),
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
                  child: Text("Register"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
