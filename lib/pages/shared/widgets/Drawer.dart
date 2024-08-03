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
      child: ListView(
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
              accountName: Text("${User.getUserUsername()}"),
              accountEmail: Text("${User.getUserEmail()}")),
          Card(
            child: ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.redAccent,
              ),
              title: Text(
                'Home Page',
                style: TextStyle(color: Colors.redAccent),
              ),
              trailing: Icon(
                Icons.navigate_next,
                color: Colors.redAccent,
              ),
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
              leading: Icon(
                Icons.shopping_cart,
                color: Colors.redAccent,
              ),
              title: Text('Products Page',
                  style: TextStyle(color: Colors.redAccent)),
              trailing: Icon(
                Icons.navigate_next,
                color: Colors.redAccent,
              ),
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
              leading: Icon(
                Icons.add_shopping_cart,
                color: Colors.redAccent,
              ),
              title:
                  Text('My Basket', style: TextStyle(color: Colors.redAccent)),
              trailing: Icon(
                Icons.navigate_next,
                color: Colors.redAccent,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => MyBasket(),
                  ),
                );
              },
            ),
          ),
          Visibility(
            visible: User.getIsLogin(),
            child: Card(
              elevation: 1,
              child: ListTile(
                shape: CircleBorder(eccentricity: 0),
                leading: Icon(
                  Icons.shopping_basket,
                  color: Colors.redAccent,
                ),
                title:
                    Text('Order me', style: TextStyle(color: Colors.redAccent)),
                trailing: Icon(
                  Icons.navigate_next,
                  color: Colors.redAccent,
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => OrderPage(),
                    ),
                  );
                },
              ),
            ),
          ),
          Visibility(
            child: Card(
              child: ListTile(
                  leading: Icon(
                    Icons.login,
                    color: Colors.redAccent,
                  ),
                  title:
                      Text('Login', style: TextStyle(color: Colors.redAccent)),
                  trailing: Icon(
                    Icons.navigate_next,
                    color: Colors.redAccent,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => Login(),
                      ),
                    );
                  }),
            ),
          ),
          Visibility(
            visible: User.getIsLogin(),
            child: Card(
              child: ListTile(
                leading: Icon(
                  Icons.update,
                  color: Colors.redAccent,
                ),
                title: Text('Update User',
                    style: TextStyle(color: Colors.redAccent)),
                trailing: Icon(
                  Icons.navigate_next,
                  color: Colors.redAccent,
                ),
                onTap: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => UpdateUser(),
                    ),
                  );
                },
              ),
            ),
          ),
          Visibility(
            visible: User.getIsLogin(),
            child: Card(
              child: ListTile(
                leading: Icon(
                  Icons.output,
                  color: Colors.redAccent,
                ),
                title:
                    Text('Logout', style: TextStyle(color: Colors.redAccent)),
                trailing: Icon(
                  Icons.navigate_next,
                  color: Colors.redAccent,
                ),
                onTap: () async {
                  User.setIsLogin(false);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => HomePage(),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
