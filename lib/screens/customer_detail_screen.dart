import 'package:flutter/material.dart';
import '../models/customer_model.dart';
import '../core/database_helper.dart';

class CustomerDetailScreen extends StatefulWidget {
  final Customer customer;

  const CustomerDetailScreen({super.key, required this.customer});

  @override
  _CustomerDetailScreenState createState() => _CustomerDetailScreenState();
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  double _balance = 0.0;
  List<String> _orders = [];

  @override
  void initState() {
    super.initState();
    _balance = widget.customer.balance;
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    // Fetch previous orders from the database (to be implemented)
    setState(() {
      _orders = ["Order 1", "Order 2", "Order 3"]; // Sample data
    });
  }

  void _addBalance() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController amountController = TextEditingController();
        return AlertDialog(
          title: Text("Add Balance"),
          content: TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Enter amount"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                double amount = double.tryParse(amountController.text) ?? 0.0;
                setState(() {
                  _balance += amount;
                });
                // Update the database (to be implemented)
                Navigator.pop(context);
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Customer Details")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name: ${widget.customer.name}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "Mobile: ${widget.customer.mobile}",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "Address: ${widget.customer.address}",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "Balance: \$_${_balance.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              "Previous Orders:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _orders.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(_orders[index]));
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "editCustomer",
            onPressed: () {
              // Navigate to edit customer screen (to be implemented)
            },
            tooltip: "Edit Customer",
            child: Icon(Icons.edit),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "addBalance",
            onPressed: _addBalance,
            tooltip: "Add Balance",
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
