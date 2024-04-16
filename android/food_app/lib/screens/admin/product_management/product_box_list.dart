import 'package:flutter/material.dart';
import 'package:food_app/constants/backend_config.dart';
import 'package:food_app/data/product.dart';
import 'package:food_app/screens/admin/product_management/add_or_update_product.dart';
import 'package:food_app/screens/admin/product_management/product_management_page.dart';
import 'package:food_app/utils/dialog.dart';

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
                  child: Text('Delete'),
                ),
              ],
              onSelected: (value) async {
                switch (value) {
                  case 1: {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddOrUpdateProductPage(product: product),
                      ),
                    );
                    break;
                  }
                  case 2: {
                    final ok = await Product.deleteProduct(product.id);
                    if (ok) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => const ProductPage()));
                    } else {
                      showAlertDialog(context, "Failed to delete Product", "Error");
                    }
                    break;
                  }
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
