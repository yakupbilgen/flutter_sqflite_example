
import 'package:flutter_sqflite_example/models/product.dart';
import 'package:path/path.dart';
import "package:sqflite/sqflite.dart";

class DbHelper {
  Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), "etrade.db");
    var eTradeDb = openDatabase(dbPath, version: 1, onCreate: createDb);
    return eTradeDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Products(id INTEGER primary key,name TEXT,description TEXT,unitPrice INTEGER)");
  }

  Future<List<Product>> getProducts() async {
    Database db = await this.db;
    var result = await db.query("Products");

    return List.generate(result.length, (i) {
      return Product.fromObject(result[i]);
    });
  }

  Future<int> insertProduct(Product product) async {
    Database db = await this.db;
    var result = await db.insert("Products", product.toMap());

    print("result sayısı: $result)");

    return result;
  }

  Future<int> deleteProduct(int id) async {
    Database db = await this.db;
    var result = await db.rawDelete("DELETE FROM Products WHERE id=$id");

    return result;
  }

  Future<int> updateProduct(Product product) async {
    Database db = await this.db;
    var result = await db.update("Products", product.toMap(),
        where: "id=?", whereArgs: [product.id]);

    return result;
  }
}
