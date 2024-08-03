import 'package:shared_preferences/shared_preferences.dart';

class User {
  static int id = 1;
  static late String username;
  static late String email;
  static late String password;
  static bool? islogin;
  static late SharedPreferences prefs;
  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static setIsLogin(bool islogin) async {
    await init();
    await prefs.setBool('islogin', islogin);
  }

  static userPassword(String password) async {
    init();

    await prefs.setString('password', password);
  }

  static userEmail(String email) async {
    await init();

    await prefs.setString('email', email);
  }

  static userUsername(String username) async {
   await init();

    await prefs.setString('username', username);
  }

  static userId(int id) async {
    init();

    await prefs.setInt('id', id);
  }

  static getUserId() {
    return prefs.get('id');
  }

  static getUserEmail() {
    return prefs.get('email') ?? "User@email.com".toString();
  }

  static getUserUsername() {
    return prefs.get('username') ?? "User";
  }

  static getUserPassword() {
    return prefs.get('password') ?? "emilyspass";
  }

  static getIsLogin() {
    return prefs.get('islogin') ?? false;
  }

  static userToken(String token) async {
    await prefs.setString('token', token);
  }

  static getUserToken() {
    return prefs.get('token');
  }
}
