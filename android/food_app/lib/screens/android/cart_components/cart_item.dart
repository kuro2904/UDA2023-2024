import 'package:flutter/cupertino.dart';
import 'package:food_app/constants/backend_config.dart';
import 'package:food_app/data/OrderDetail.dart';

class CartItem extends StatefulWidget {
  final OrderDetail item;

  const CartItem({super.key, required this.item});

  @override
  State<StatefulWidget> createState() => CartItemState();

}
class CartItemState extends State<CartItem>{

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: CupertinoColors.black)
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: widget.item.product.imageUrl == null
                    ? const Text('No image')
                    : Image.network(
                    BackEndConfig.fetchImageString +  widget.item.product.imageUrl!, height: 90,width: 90,),
              ),
              Text( widget.item.product.name, style: const TextStyle(fontSize: 25),),
              Text(widget.item.quantity.toString(), style: const TextStyle(fontSize: 25))

            ],
          ),
        ),
      ),
    );
  }
}