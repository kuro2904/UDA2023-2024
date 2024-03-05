
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/data/client_state.dart';
import 'package:food_app/data/delivery_man.dart';
import 'package:http/http.dart' as http;
import '../../../constants/backend_config.dart';
import 'add_update_delivery_man.dart';


class DeliveryMenBoxList extends StatefulWidget {
  final List<DeliveryMan> items;

  const DeliveryMenBoxList(this.items, {super.key});

  @override
  State<StatefulWidget> createState() => CategoryBoxState();
}

class CategoryBoxState extends State<DeliveryMenBoxList> {

  Future<void> deleteDeliveryMan(DeliveryMan item) async {
    final response = await http.delete(Uri.parse(BackEndConfig.deleteDeliveryManString + item.id),headers: ClientState().headerWithAuth);
    if (response.statusCode == 200) {
      setState(() {
        widget.items.remove(item);
      });
    } else {
      showDialog(
        context: context, // Use the stored context
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
                Text(
                  widget.items[index].id,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.items[index].name,
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
                        deleteDeliveryMan(item); // Call the function directly
                      } else if (value == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  AddOrUpdateDeliveryManPage(deliveryMan: item),
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

