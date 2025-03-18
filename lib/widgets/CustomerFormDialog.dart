import 'package:flutter/material.dart';
import 'package:smarttailor/core/customer_repository.dart';
import '../core/database_helper.dart';
import '../models/customer_model.dart';

class Customerformdialog extends StatefulWidget {
  final Customer? customer;
  final Function()? onSuccess;

  const Customerformdialog({super.key, this.customer, this.onSuccess});

  @override
  State<StatefulWidget> createState() {
    return _CustomerformdialogState();
  }
}

class _CustomerformdialogState extends State<Customerformdialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _mobileController;
  late TextEditingController _addressController;
  late TextEditingController _balanceController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController(text: widget.customer?.name ?? '');
    _mobileController = TextEditingController(
      text: widget.customer?.mobile ?? '',
    );
    _addressController = TextEditingController(
      text: widget.customer?.address ?? '',
    );
    _balanceController = TextEditingController(
      text: widget.customer?.balance?.toString() ?? '0.0',
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.customer == null ? 'Add Customer' : 'Edit Customer'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField("Name", _nameController, TextInputType.text),
              _buildTextField("Mobile", _mobileController, TextInputType.phone),
              _buildTextField(
                "Address",
                _addressController,
                TextInputType.text,
              ),
              _buildTextField(
                "Balance",
                _balanceController,
                TextInputType.number,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(onPressed: _saveCustomer, child: Text('Save')),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    TextInputType inputType,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label is required';
          }
          return null;
        },
      ),
    );
  }

  Future<void> _saveCustomer() async {
    final customerRepository = CustomerRepository();

    if (_formKey.currentState?.validate() ?? false) {
      final customer = Customer(
        id: widget.customer?.id, // Ensure ID is assigned when editing
        name: _nameController.text,
        mobile: _mobileController.text,
        address: _addressController.text,
        balance: double.tryParse(_balanceController.text) ?? 0.0,
      );

      if (widget.customer == null) {
        await customerRepository.insertCustomer(customer);
      } else {
        await customerRepository.updateCustomer(customer, customer.id!);
      }

      widget.onSuccess?.call();
      Navigator.pop(context);
    }
  }
}
