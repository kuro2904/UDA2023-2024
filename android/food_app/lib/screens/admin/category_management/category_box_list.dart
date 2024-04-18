import 'package:flutter/material.dart';
import 'package:food_app/constants/backend_config.dart';
import 'package:food_app/data/category.dart';
import 'package:http/http.dart' as http;

import '../../../data/client_state.dart';
import '../../../screens/admin/category_management/add_update_category.dart';
import '../../../screens/admin/category_management/category_management_page.dart';

class CategoryBoxList extends StatelessWidget {
  final List<Category> items;

  const CategoryBoxList(this.items, {super.key});

  Future<void> deleteCategory(Category item, BuildContext context) async {
    final header = {
      'Authorization': ClientState().token,
      'Content-Type': 'application/json; charset=UTF-8'
    };

    final response = await http.delete(
      Uri.parse(BackEndConfig.deleteCategoryString + item.id),
      headers: header,
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Category deleted successfully'),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CategoryPage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content:
              const Text('Failed to delete category. Please try again later.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final category = items[index];
        return SizedBox(
          height: 90,
          child: Card(
            color: Colors.greenAccent,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              leading: SizedBox(
                width: 100,
                height: 100,
                child: category.imageUrl!.isNotEmpty
                    ? Image.network(
                  BackEndConfig.fetchImageString + category.imageUrl!,
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                )
                    : const SizedBox(
                  width: 100,
                  height: 100,
                  child: Center(child: Text('No image')),
                ),
              ),
              title: Text(
                category.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                category.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(fontWeight: FontWeight.w400),
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
                  if (value == 2) {
                    await deleteCategory(category, context);
                  } else if (value == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddOrUpdateCategoryPage(category: category),
                      ),
                    );
                  }
                },
                child: const Icon(Icons.more_horiz),
              ),
            ),
          ),
        );
      },
    );
  }
}
