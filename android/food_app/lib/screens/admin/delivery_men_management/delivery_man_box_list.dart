import 'package:flutter/material.dart';
import 'package:food_app/data/delivery_man.dart';
import 'package:http/http.dart' as http;

import '../../../constants/backend_config.dart';
import '../../../data/client_state.dart';
import 'add_update_delivery_man.dart';

class DeliveryMenBoxList extends StatefulWidget {
  final List<DeliveryMan> items;

  const DeliveryMenBoxList(this.items, {Key? key});

  @override
  State<StatefulWidget> createState() => DeliveryMenBoxListState();
}

class DeliveryMenBoxListState extends State<DeliveryMenBoxList> {
  Future<void> deleteDeliveryMan(DeliveryMan item) async {
    final Map<String, String> header = {
      'Authorization': ClientState().token,
      'Content-Type': 'application/json'
    };
    final response = await http.delete(
      Uri.parse(BackEndConfig.deleteDeliveryManString + item.id),
      headers: header,
    );
    if (response.statusCode == 200) {
      setState(() {
        widget.items.remove(item);
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text(
              'Failed to delete delivery man. Please try again later.'),
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
      child: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: widget.items.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final deliveryMan = widget.items[index];
          return ListTile(
            title: Text(
              '${deliveryMan.id} - ${deliveryMan.name}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: PopupMenuButton<int>(
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: 1,
                  child: Text('Show Details'),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text('Delete'),
                ),
              ],
              onSelected: (value) async {
                switch (value) {
                  case 2:
                    await deleteDeliveryMan(deliveryMan);
                    break;
                  case 1:
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddOrUpdateDeliveryManPage(
                            deliveryMan: deliveryMan),
                      ),
                    );
                    break;
                  default:
                }
              },
              child: const Icon(Icons.more_horiz),
            ),
          );
        },
      ),
    );
  }
}
