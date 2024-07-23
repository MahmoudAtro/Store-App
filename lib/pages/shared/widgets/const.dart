import 'package:flutter/material.dart';

var decoration = InputDecoration(
    hintText: "username",
    hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
    contentPadding: EdgeInsets.symmetric(vertical: 3, horizontal: 25),
    filled: true,
    fillColor: Colors.grey[200],
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide:
            BorderSide(color: const Color.fromARGB(255, 184, 184, 184))),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40),
        borderSide: BorderSide(color: Colors.grey)));
