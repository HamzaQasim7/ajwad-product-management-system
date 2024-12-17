import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../presentations/models/product_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('products.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        unitPrice REAL NOT NULL,
        unit TEXT NOT NULL
      )
    ''');
    // Create the 'bill_items' table
    await db.execute('''
      CREATE TABLE bill_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        quantity INTEGER NOT NULL,
        unit TEXT NOT NULL,
        unitPrice REAL NOT NULL,
        totalPrice REAL NOT NULL
      )
    ''');
  }

  Future<int> insertProduct(Product product) async {
    final db = await instance.database;
    return await db.insert('products', product.toMap());
  }

  Future<List<Product>> getAllProducts() async {
    final db = await instance.database;
    final result = await db.query('products');
    return result.map((map) => Product.fromMap(map)).toList();
  }

  // Delete a product by ID
  Future<void> deleteProduct(int id) async {
    if (_database == null) return;
    await _database!.delete('products', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateProduct(Product updatedProduct) async {
    if (_database == null) return;

    await _database!.update(
      'products',
      updatedProduct.toMap(),
      where: 'id = ?',
      whereArgs: [updatedProduct.id],
    );
  }

  // Insert a bill item into the 'bill_items' table
  Future<int> insertBillItem(Map<String, dynamic> item) async {
    final db = await instance.database;
    return await db.insert('bill_items', item);
  }

  // Fetch all bill items from the 'bill_items' table
  Future<List<Map<String, dynamic>>> getAllBillItems() async {
    final db = await instance.database;
    return await db.query('bill_items');
  }

  // Delete a bill item by ID
  Future<void> deleteBillItem(int id) async {
    final db = await instance.database;
    await db.delete('bill_items', where: 'id = ?', whereArgs: [id]);
  }

  // Clear all bill items (used on checkout)
  Future<void> clearBillItems() async {
    final db = await instance.database;
    await db.delete('bill_items');
  }
}
