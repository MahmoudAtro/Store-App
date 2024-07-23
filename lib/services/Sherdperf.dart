import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User extends ChangeNotifier {
  static int id = 1;
  static String username = "User";
  static String email = "User@email.com";
  static String password = 'emilyspass';
  static bool? islogin;
  static late final SharedPreferences prefs;
  static setIsLogin(bool islogin) async {
    prefs = await SharedPreferences.getInstance();

    await prefs.setBool('islogin', islogin);
  }

  static userPassword(String password) async {
    prefs = await SharedPreferences.getInstance();

    await prefs.setString('password', email);
  }

  static userEmail(String email) async {
    prefs = await SharedPreferences.getInstance();

    await prefs.setString('email', email);
  }

  static userUsername(String username) async {
    prefs = await SharedPreferences.getInstance();

    await prefs.setString('username', username);
  }

  static userId(int id) async {
    prefs = await SharedPreferences.getInstance();

    await prefs.setInt('id', id);
  }

  static getUserId() {
    return prefs.get('id');
  }

  static getUserEmail() {
    return prefs.get('email');
  }

  static getUserUsername() {
    return prefs.get('username');
  }

  static getUserPassword() {
    return prefs.get('password');
  }

  static getIsLogin() {
    return prefs.get('islogin') ?? false;
  }

  static userToken(String token) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static getUserToken() {
    return prefs.get('token');
  }
}
