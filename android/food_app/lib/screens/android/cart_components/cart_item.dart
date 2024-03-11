import 'package:flutter/cupertino.dart';
import 'package:food_app/constants/backend_config.dart';
import 'package:food_app/data/product.dart';
import 'package:numberpicker/numberpicker.dart';

class CartItem extends StatefulWidget {
  final Product item;

  const CartItem({super.key, required this.item});

  @override
  State<StatefulWidget> createState() => CartItemState();

}
class CartItemState extends State<CartItem>{
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: widget.item.imageUrl == null
                  ? const Text('No image')
                  : Image.network(
                  BackEndConfig.fetchImageString +  widget.item.imageUrl!),
            ),
            Text(widget.item.name),
            NumberPicker(minValue: 0, maxValue: 10, value: quantity, onChanged: (value){
              setState(() {
                quantity = value;
              });
            })
          ],
        ),
      ),
    );
  }
}