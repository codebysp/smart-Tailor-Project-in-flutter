import 'package:sqflite_common/sqflite.dart';
import '../models/customer_model.dart';
import 'database_helper.dart';

class CustomerRepository {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  Future<int> insertCustomer(Customer customer) async {
    final db = await dbHelper.database;
    return await db.insert('customers', customer.toMap());
  }

  Future<List<Customer>> getCustomers() async {
    final db = await dbHelper.database;
    final result = await db.query('customers');
    return result.map((map) => Customer.fromMap(map)).toList();
  }

  Future<Customer?> getCustomer(int id) async {
    final db = await dbHelper.database;
    final result = await db.query(
      'customers',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return Customer.fromMap(result.first);
    }
    return null;
  }

  Future<int> updateCustomer(Customer customer, int id) async {
    final db = await dbHelper.database;
    return await db.update(
      'customers',
      customer.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteCustomer(int id) async {
    final db = await dbHelper.database;
    return await db.delete('customers', where: 'id = ?', whereArgs: [id]);
  }
}
