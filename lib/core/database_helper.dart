import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import '../models/customer_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('smart_tailor.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    print('Database Path: $path'); // Print Path Here

    return await databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(version: 1, onCreate: _createDB),
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE customers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        mobile TEXT NOT NULL,
        address TEXT NOT NULL,
        balance REAL NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE products(
        product_id INTEGER PRIMARY KEY AUTOINCREMENT,
        product_type TEXT CHECK(product_type IN ('Service',Product)) NOT NULL,
        product_name TEXT NOT NULL,
        product_description TEXT,
        purchase_rate REAL,
        selling_rate REAL NOT NULL,
        labour_charge REAL,
        comapny_name TEXT,
      )
''');
  }


}
