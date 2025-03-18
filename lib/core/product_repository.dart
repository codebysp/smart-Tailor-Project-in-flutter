import 'package:sqflite_common/sqflite.dart';
import '../models/product_model.dart';
import 'database_helper.dart';

class ProductRepository {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  Future<int> insertProduct(Product product) async {
    final db = await dbHelper.database;
    return await db.insert('products', product.toMap());
  }

  Future<List<Product>> getProducts() async {
    final db = await dbHelper.database;
    final result = await db.query('products');
    return result.map((map) => Product.fromMap(map)).toList();
  }

  Future<Product?> getProduct(int id) async {
    final db = await dbHelper.database;
    final result = await db.query(
      'products',
      where: 'product_id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? Product.fromMap(result.first) : null;
  }

  Future<int> updateProduct(Product product) async {
    final db = await dbHelper.database;
    return await db.update(
      'products',
      product.toMap(),
      where: 'product_id = ?',
      whereArgs: [product.productId],
    );
  }

  Future<int> deleteProduct(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'products',
      where: 'product_id = ?',
      whereArgs: [id],
    );
  }
}
