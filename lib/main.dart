import 'package:flutter/material.dart';
import 'package:smarttailor/screens/CustomerScreen.dart';
import 'screens/HomeScreen.dart';
import 'core/database_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database; // Ensure database initialization
  await DatabaseHelper.instance.printDatabasePath();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tailor Management',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
      routes: {
        '/customers': (context) => CustomerListScreen(),
        '/orders': (context) => const OrderScreen(),
        '/products': (context) => const ProductScreen(),
        '/reports': (context) => const ReportScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    ),
  );
}

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      body: const Center(child: Text('Order Screen')),
    );
  }
}

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: const Center(child: Text('Product Screen')),
    );
  }
}

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: const Center(child: Text('Report Screen')),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(child: Text('Settings Screen')),
    );
  }
}
