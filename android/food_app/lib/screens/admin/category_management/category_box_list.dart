

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../../../constants/backend_config.dart';
import '../../../data/category.dart';
import 'add_update_category.dart';


class CategoryBoxList extends StatefulWidget {
  final List<Category> items;

  const CategoryBoxList(this.items, {super.key});

  @override
  State<StatefulWidget> createState() => CategoryBoxState();
}

class CategoryBoxState extends State<CategoryBoxList> {


  Future<void> deleteCategory(Category item) async {
    final context = this.context;
    final response = await http.delete(Uri.parse(BackEndConfig.deleteCategoryString + item.id));
    if (response.statusCode == 200) {
      setState(() {
        widget.items.remove(item);
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Failed to delete category. Please try again later.'),
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
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            padding: EdgeInsets.zero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  BackEndConfig.fetchImageString + widget.items[index].imageUrl,
                  fit: BoxFit.cover,
                  width: 150,
                  height: 150,
                ),
                Text(
                  widget.items[index].name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.items[index].description,
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
                PopupMenuButton<int>(
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
                    final item = widget.items[index];
                    try {
                      if (value == 3) {
                        await deleteCategory(item);
                      } else if (value == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  AddOrUpdateCategoryPage(category: item),
                          ),
                        );
                      }
                    } catch (error) {
                      print('Error: $error');
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Error'),
                          content: const Text('Failed to perform operation. Please try again later.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Icon(Icons.more_horiz),
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}
