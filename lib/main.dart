import 'package:appstore/pages/home/home_page.dart';
import 'package:appstore/pages/shared/models/Provider.dart';
import 'package:appstore/services/Sherdperf.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
  User.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //   providers: [
    //     Provider<Model>(create: (_) => Model()),
    //     Provider<User>(create: (_) => User()),
    //   ],

    return ChangeNotifierProvider(
      create: (context) => Model(),
      child: MaterialApp(
        debugShowMaterialGrid: false,
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
