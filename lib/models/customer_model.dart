class Customer {
  int? id;
  String name;
  String mobile;
  String address;
  double balance;

  Customer({
    this.id,
    required this.name,
    required this.mobile,
    required this.address,
    required this.balance,
  });

  // Convert a Customer object to a Map
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'name': name,
      'mobile': mobile,
      'address': address,
      'balance': balance,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  // Create a Customer object from a Map
  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'] is int ? map['id'] : null,
      name: map['name'] ?? '',
      mobile: map['mobile'] ?? '',
      address: map['address'] ?? '',
      balance: (map['balance'] ?? 0.0).toDouble(),
    );
  }
}
