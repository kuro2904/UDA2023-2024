import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/constants/backend_config.dart';
import 'package:food_app/data/OrderDetail.dart';
import 'package:food_app/data/client_state.dart';
import 'package:food_app/data/product.dart';
import 'package:food_app/utils/pick_number_dialog.dart';

class ProductDetail extends StatefulWidget {
  final Product item;

  const ProductDetail({super.key, required this.item});

  @override
  State<StatefulWidget> createState()=> ProductDetailState();
}

class ProductDetailState extends State<ProductDetail> {
  int quantity = 1; // Declare quantity as a class-level variable

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    TextEditingController controller = TextEditingController(text: '1');

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            CircleAvatar(
              radius: 100,
              foregroundImage:
              NetworkImage(BackEndConfig.fetchImageString + item.imageUrl!),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(item.description,
                style: const TextStyle(color: Colors.black, fontSize: 30)),
            Text(item.price,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 30,),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return PickNumberDialog(controller: controller, quantity: quantity, function: (){
                      ClientState().cart.add(OrderDetail(quantity: quantity, product: item));
                      Navigator.pop(context);
                      Navigator.pop(context);
                    });
                  },
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              child: const Text(
                'Add to cart',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

