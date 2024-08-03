import 'dart:convert';

import 'package:appstore/pages/home/home_page.dart';
import 'package:appstore/pages/shared/widgets/Snackbar.dart';
import 'package:appstore/pages/shared/widgets/const.dart';
import 'package:appstore/pages/shared/widgets/custombuttonauth.dart';
import 'package:appstore/pages/shared/widgets/customlogoauth.dart';
import 'package:appstore/services/Sherdperf.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateUser extends StatefulWidget {
  const UpdateUser({super.key});

  @override
  State<UpdateUser> createState() => _UpdateUserPage();
}

class _UpdateUserPage extends State<UpdateUser> {
  final _keyForm = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isVisble = true;
  bool isloding = false;
  Future<void> updateUser() async {
    setState(() {
      isloding = true;
    });

    final url = Uri.parse('https://dummyjson.com/users/1');
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username.text,
        'email': email.text,
        'password': password.text
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      User.userEmail(data['email']);
      User.userUsername(data['username']);
      User.password = password.text;
      ShowsnackBar(context, "Account successfully Updated");

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      ShowsnackBar(
          context, " update failed. Status code: ${response.statusCode}");
    }

    setState(() {
      isloding = false;
    });
  }

  getuserDate() async {
    try {
      final response = await http.get(Uri.parse('https://dummyjson.com/users/1'));
      final data = jsonDecode(response.body);
      username.text = User.getUserUsername();
      email.text = User.getUserEmail();
      password.text = User.getUserPassword();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getuserDate();
    super.initState();
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
                logo: "assets/update.jpeg",
              ),
              Container(height: 20),
              const Text("UpdateUser",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              Container(height: 10),
              const Text("UpdateUser To Continue Using The App",
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
            ],
          ),
          Container(height: 30),
          isloding
              ? Center(child: CircularProgressIndicator())
              : CustomButtonAuth(
                  title: "UpdateUser",
                  onPressed: () {
                    // if (_keyForm.currentState!.validate()) {
                    updateUser();
                    // }
                  }),
          Container(height: 20),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    username.clear();
    email.clear();
    password.clear();
    // TODO: implement dispose
    super.dispose();
  }
}
