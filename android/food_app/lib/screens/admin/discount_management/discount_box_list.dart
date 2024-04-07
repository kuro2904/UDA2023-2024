import 'package:flutter/material.dart';

import '../../../data/discount.dart';

class DiscountBoxList extends StatefulWidget {
  final List<Discount> items;

  const DiscountBoxList(this.items, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DiscountBoxListState();
}

class DiscountBoxListState extends State<DiscountBoxList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final discount = widget.items[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Card(
              color: Colors.greenAccent,
              elevation: 3,
              child: ListTile(
                title: Text(
                  'ID: ${discount.id}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      'Discount Percent: ${discount.discountPercent}%',
                      style: const TextStyle(fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Start Date: ${_formatDate(discount.startDate)}',
                      style: const TextStyle(fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Expired Date: ${_formatDate(discount.expiredDate)}',
                      style: const TextStyle(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatDate(String date) {
    // You can implement your own date formatting logic here
    return date; // Return the original date for now
  }
}
