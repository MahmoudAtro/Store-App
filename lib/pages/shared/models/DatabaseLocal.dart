import 'package:appstore/pages/shared/models/Order.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Datame {
  static var database;

  static Future<Database> data() async {
    if (database == null) {
      database = await Datame.initdatabase();
      return database;
    } else {
      return database;
    }
  }

  static Future<Database> initdatabase() async {
    var data = await openDatabase(
      join(await getDatabasesPath(), 'Order_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE Orders(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,title TEXT,description TEXT,price TEXT,image TEXT)',
        );
      },
      version: 32,
    );
    return data;
  }

  static Future<void> insertOrder(Order order) async {
    // Get a reference to the database.
    final db = await Datame.data();
    await db.insert(
      'Orders',
      order.toMap(),
    );
  
  }

  static getAllOrder() async {
    var database = await Datame.data();
    var db = await database.query('Orders');
    return db;
  }
}
