import 'package:flutter/material.dart';
import '../models/customer_model.dart';
import '../core/database_helper.dart';
import 'customer_detail_screen.dart';
import 'package:flutter/services.dart';
import '../widgets/CustomerFormDialog.dart';
import '../core/customer_repository.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  _CustomerListScreenState createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  List<Customer> _customers = [];
  List<Customer> _filteredCustomers = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCustomers();
    _searchController.addListener(_filterCustomers);
  }

  Future<void> _loadCustomers() async {
    final customerRepository = CustomerRepository();
    final customers = await customerRepository.getCustomers();
    setState(() {
      _customers = customers;
      _filteredCustomers = customers;
    });
  }

  void _addNewCustomer() {
    showDialog(
      context: context,
      builder: (context) => Customerformdialog(onSuccess: _loadCustomers),
    );
  }

  void _filterCustomers() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCustomers =
          _customers.where((customer) {
            final nameLower = customer.name.toLowerCase();
            final mobileLower = customer.mobile.toLowerCase();
            return nameLower.contains(query) || mobileLower.contains(query);
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Customer List')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Customer',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredCustomers.length,
              itemBuilder: (context, index) {
                final customer = _filteredCustomers[index];
                return ListTile(
                  title: Text(customer.name),
                  subtitle: Text(customer.mobile),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                CustomerDetailScreen(customer: customer),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.f2): const ActivateIntent(),
        },
        child: Actions(
          actions: <Type, Action<Intent>>{
            ActivateIntent: CallbackAction<ActivateIntent>(
              onInvoke: (ActivateIntent intent) => _addNewCustomer(),
            ),
          },
          child: FloatingActionButton(
            onPressed: _addNewCustomer,
            child: const Icon(Icons.add),
            tooltip: 'Add New Customer (F2)', // Indicate the shortcut
          ),
        ),
      ),
    );
  }
}
