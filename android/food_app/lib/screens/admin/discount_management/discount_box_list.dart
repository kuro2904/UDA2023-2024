import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/data/discount.dart';

class DiscountBoxList extends StatefulWidget {
  final List<Discount> items;
  const DiscountBoxList(this.items, {super.key});

  @override
  State<StatefulWidget> createState() => DiscountBoxListState();
}

class DiscountBoxListState extends State<DiscountBoxList>{

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.items[index].id,
                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
                ),
                Text(
                  widget.items[index].discountPercent.toString(),
                  style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 20),
                ),
                Text(
                  widget.items[index].startDate,
                  style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 20),
                ),
                Text(
                  widget.items[index].expiredDate,
                  style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 20),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

}
