import 'dart:convert';

import 'package:appstore/pages/auth/register.dart';
import 'package:appstore/pages/home/home_page.dart';
import 'package:appstore/pages/shared/widgets/Snackbar.dart';
import 'package:appstore/pages/shared/widgets/const.dart';
import 'package:appstore/pages/shared/widgets/custombuttonauth.dart';
import 'package:appstore/pages/shared/widgets/customlogoauth.dart';
import 'package:appstore/services/Sherdperf.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _key = GlobalKey<FormState>();
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool isVisble = true;
  bool isloding = false;

  Future<void> login() async {
    setState(() {
      isloding = true;
    });

    final response = await http.post(
      Uri.parse('https://dummyjson.com/users/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': "emilys",
        'password': "emilyspass",
      }),
    );
    if (response.statusCode == 200) {
    
      
      if (_username.text == User.getUserUsername() &&
          _password.text == User.getUserPassword()) {
        setState(() {
          User.setIsLogin(true);
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    } else {
      ShowsnackBar(
          context, 'Login failed. Status code: ${response.statusCode}');
    }

    if (mounted) {
      setState(() {
        isloding = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 50),
              CustomLogoAuth(
                logo: "assets/logo/login.png",
              ),
              Container(height: 20),
              const Text("Login",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              Container(height: 10),
              const Text("Login To Continue Using The App",
                  style: TextStyle(color: Colors.grey)),
              Container(height: 20),
              const Text(
                "Username",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 10),
              TextFormField(
                controller: _username,
                keyboardType: TextInputType.emailAddress,
                decoration: decoration.copyWith(
                    hintText: "Enter your username :",
                    suffixIcon: Icon(Icons.email)),
              ),
              Container(height: 10),
              const Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 10),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (password) {
                  if (password!.length < 8) {
                    return "Enter a valid password";
                  }
                },
                controller: _password,
                obscureText: isVisble,
                decoration: decoration.copyWith(
                    hintText: "Enter your password :",
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisble = !isVisble;
                          });
                        },
                        icon: isVisble
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off))),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                alignment: Alignment.topRight,
                child: const Text(
                  "Forgot Password ?",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          isloding
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : CustomButtonAuth(
                  title: "login",
                  onPressed: () async {
                    await login();
                    // if (_key.currentState!.validate()) {

                    // }
                  }),

          Container(height: 20),
          // Text("Don't Have An Account ? Resister" , textAlign: TextAlign.center,)
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Registre()));
            },
            child: const Center(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Have An Account ? ",
                ),
                TextSpan(
                    text: "Register",
                    style: TextStyle(
                        color: Colors.orange, fontWeight: FontWeight.bold)),
              ])),
            ),
          )
        ]),
      ),
    );
  }

  void dispose() {
    _username.clear();

    _password.clear();
    // TODO: implement dispose
    super.dispose();
  }
}
