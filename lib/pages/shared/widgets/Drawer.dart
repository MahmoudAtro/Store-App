import 'package:appstore/pages/auth/login.dart';
import 'package:appstore/pages/auth/updateUserPase.dart';
import 'package:appstore/pages/cart/Mybasket.dart';
import 'package:appstore/pages/home/home_page.dart';
import 'package:appstore/pages/home/widgets/OrderPage.dart';
import 'package:appstore/pages/products/ProductsPage.dart';
import 'package:appstore/services/Sherdperf.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
              arrowColor: const Color.fromARGB(255, 238, 238, 238),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/drower.jpg'), fit: BoxFit.cover),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/me.jpg'),
              ),
              accountName: Text("${User.username}"),
              accountEmail: Text("${User.email}")),
          Card(
            child: ListTile(
              leading: Icon(Icons.home),
              title: Text('Home Page'),
              trailing: Icon(Icons.navigate_next),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => HomePage(),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text('Products Page'),
              trailing: Icon(Icons.navigate_next),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ProductsPage(),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.add_shopping_cart),
              title: Text('My Basket'),
              trailing: Icon(Icons.navigate_next),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => MyBasket(),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.add_shopping_cart),
              title: Text('Order me'),
              trailing: Icon(Icons.navigate_next),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => OrderPage(),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
                leading: Icon(Icons.login),
                title: Text('Login'),
                trailing: Icon(Icons.navigate_next),
                onTap: () {
                  // if (context.read<Model>().getchecklogin()) {
                  //   AwesomeDialog(
                  //     context: context,
                  //     dialogType: DialogType.error,
                  //     animType: AnimType.rightSlide,
                  //     title: 'You have already logged in',
                  //     desc: '',
                  //     btnCancelOnPress: () {},
                  //     btnOkOnPress: () {},
                  //   ).show();
                  // } else {}
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => Login(),
                    ),
                  );
                }),
          ),
          //     if(User.getIsLogin())
          Card(
            child: ListTile(
              leading: Icon(Icons.update),
              title: Text('Update User'),
              trailing: Icon(Icons.navigate_next),
              onTap: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => UpdateUser(),
                  ),
                );
              },
            ),
          ),

          // if (User.getIsLogin())
            Card(
              child: ListTile(
                leading: Icon(Icons.output),
                title: Text('Logout'),
                trailing: Icon(Icons.navigate_next),
                onTap: () async {
                  // User.setIsLogin(false);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => Login(),
                    ),
                  );
                },
              ),
            )
        ],
      ),
    );
  }
}
