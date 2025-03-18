import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductCard extends StatelessWidget{
  final Product product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding:   const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                product.productType == 'Service' ? Icons.build : Icons.shopping_bag,
                size: 40,
                color: product.productType == 'Service' ? Colors.blue : Colors.green,
              ),
              const SizedBox(width: 16,),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName,
                    style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4,),
                  Text(
                    product.productDescription,
                    style: const TextStyle(color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 8,),
                  Text(
                    ''
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
  
}