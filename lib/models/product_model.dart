class Product {
  final int? productId;
  final String productType;
  final String productName;
  final String productDescription;
  final double? purchaseRate;
  final double sellingRate;
  final double? labourCharge;
  final String? companyName;

  Product({
    this.productId,
    required this.productType,
    required this.productName,
    required this.productDescription,
    this.purchaseRate,
    required this.sellingRate,
    this.labourCharge,
    this.companyName,
  }) {
    if (productType != 'Service' && productType != 'Product') {
      throw ArgumentError(
        'Invaild product type.Must be either "Service" or "Product"',
      );
    }

    if (productType == 'Service' &&
        (labourCharge == null || purchaseRate != null)) {
      throw ArgumentError(
        'Labour charge is required for services and purchase rate should not be provided',
      );
    }

    if (productType == 'Product' &&
        (purchaseRate == null || labourCharge != null || companyName == null)) {
      throw ArgumentError(
        'Purchase rate and company name are required for products and lbour charge shold not be provided',
      );
    }
  }
  Map<String, dynamic> toMap() {
    if (productType != 'Service' && productType != 'Product') {
      throw ArgumentError('Inavild product type.Cannot Save to database');
    }

    return {
      'product_id': productId,
      'product_type': productType,
      'product_name': productName,
      'product_description': productDescription,
      'purchase_rate': purchaseRate ?? 0.0,
      'selling_rate': sellingRate,
      'labour_charge': labourCharge ?? 0.0,
      'company_name': companyName ?? '',
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    final requiredFields = [
      'product_id',
      'product_type',
      'product_name',
      'product_description',
      'selling_rate',
    ];

    for (var field in requiredFields) {
      if (!map.containsKey(field) || map[field] == null) {
        throw ArgumentError('Missing or null field: $field in database record');
      }
    }

    return Product(
      productId: map['product_id'],
      productType: map['product_type'],
      productName: map['product_name'],
      productDescription: map['product_description'],
      purchaseRate: map['purchase_rate'],
      sellingRate: map['selling_rate'],
      labourCharge: map['labour_charge'],
      companyName: map['company_name'],
    );
  }
}
