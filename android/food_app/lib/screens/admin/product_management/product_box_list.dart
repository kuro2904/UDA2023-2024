import 'package:flutter/material.dart';
import 'package:food_app/constants/backend_config.dart';
import 'package:food_app/data/product.dart';
import 'package:food_app/screens/admin/product_management/add_or_update_product.dart';

class ProductBoxList extends StatelessWidget {
  final List<Product> items;

  const ProductBoxList(this.items, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final product = items[index];
        return Card(
          elevation: 4,
          color: Colors.greenAccent,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            leading: SizedBox(
              width: 100,
              height: 100,
              child: product.imageUrl!.isNotEmpty
                  ? Image.network(
                      BackEndConfig.fetchImageString + product.imageUrl!,
                      fit: BoxFit.cover,
                    )
                  : const Center(child: Text('No image')),
            ),
            title: Text(
              product.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            subtitle: Text(
              product.description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            trailing: PopupMenuButton<int>(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 1,
                  child: Text('Show Details'),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text('Update'),
                ),
                const PopupMenuItem(
                  value: 3,
                  child: Text('Delete'),
                ),
              ],
              onSelected: (value) async {
                if (value == 3) {
                  // Delete functionality
                } else if (value == 2) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddOrUpdateProductPage(product: product),
                    ),
                  );
                }
              },
              child: const Icon(Icons.more_horiz),
            ),
          ),
        );
      },
    );
  }
}
