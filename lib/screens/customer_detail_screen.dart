import 'package:flutter/material.dart';
import 'package:smarttailor/core/customer_repository.dart';
import '../models/customer_model.dart';
import '../core/database_helper.dart';
import '../widgets/CustomerFormDialog.dart';

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

  // Function to refresh the customer details after editing
  Future<void> _refreshCustomerDetails() async {
    final customerRepository = CustomerRepository();

    final updatedCustomer = await customerRepository.getCustomer(
      widget.customer.id!,
    );
    if (updatedCustomer != null) {
      setState(() {
        widget.customer.name = updatedCustomer.name;
        widget.customer.mobile = updatedCustomer.mobile;
        widget.customer.address = updatedCustomer.address;
        _balance = updatedCustomer.balance;
      });
    }
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
              showDialog(
                context: context,
                builder:
                    (context) => Customerformdialog(
                      customer: widget.customer, // Pass the customer to edit
                      onSuccess: () {
                        _refreshCustomerDetails(); // Refresh the screen to show updates
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${widget.customer.name} updated'),
                          ),
                        );
                      },
                    ),
              );
            },
            tooltip: "Edit Customer",
            child: Icon(Icons.edit),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
