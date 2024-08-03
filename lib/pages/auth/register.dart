import 'dart:convert';

import 'package:appstore/pages/auth/login.dart';
import 'package:appstore/pages/shared/widgets/Snackbar.dart';
import 'package:appstore/pages/shared/widgets/const.dart';
import 'package:appstore/pages/shared/widgets/custombuttonauth.dart';
import 'package:appstore/pages/shared/widgets/customlogoauth.dart';
import 'package:appstore/services/Sherdperf.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Registre extends StatefulWidget {
  const Registre({super.key});

  @override
  State<Registre> createState() => _RegistreState();
}

class _RegistreState extends State<Registre> {
  final _keyForm = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isVisble = true;
  bool isloding = false;

  Future<void> registerUser() async {
    setState(() {
      isloding = true;
    });

    Map<String, String> userData = {
      'id': '210',
      'username': username.text,
      'email': email.text,
      'password': password.text,
    };

    final url = Uri.parse('https://dummyjson.com/users/add');
    final response = await post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(userData));

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      ShowsnackBar(context, "Account successfully created");
      User.userUsername(username.text);
      User.userEmail(email.text);
      User.userPassword(password.text);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      ShowsnackBar(
          context, " Login failed. Status code: ${response.statusCode}");
      print('Response: ${response.body}');
    }
    setState(() {
      isloding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _keyForm,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 50),
              CustomLogoAuth(
                logo: "assets/logo/registre.png",
              ),
              Container(height: 20),
              const Text("Registre",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              Container(height: 10),
              const Text("Registre To Continue Using The App",
                  style: TextStyle(color: Colors.grey)),
              Container(height: 20),
              const Text(
                "username",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 10),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: username,
                decoration: decoration.copyWith(
                    hintText: "Enter your username :",
                    suffixIcon: Icon(Icons.email)),
              ),
              Container(height: 10),
              const Text(
                "emali",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) {
                  return email!.contains(RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                      ? null
                      : "Enter a valid emial";
                },
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: decoration.copyWith(
                    hintText: "Enter your email :",
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
                controller: password,
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
                child: Text(
                  "Forgot Password ?",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          isloding
              ? Center(child: CircularProgressIndicator())
              : CustomButtonAuth(
                  title: "Registre",
                  onPressed: () {
                    // if (_keyForm.currentState!.validate()) {
                    registerUser();
                    // }
                  }),
          Container(height: 20),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            child: const Center(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Have An Account ? ",
                ),
                TextSpan(
                    text: "Login",
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
    username.clear();
    email.clear();
    password.clear();
    // TODO: implement dispose
    super.dispose();
  }
}
