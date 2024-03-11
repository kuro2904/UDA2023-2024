import 'package:flutter/material.dart';
import 'package:food_app/constants/backend_config.dart';
import 'package:food_app/data/product.dart';

class ProductDetail extends StatelessWidget {
  final Product item;

  const ProductDetail({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
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
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)
                ),
                child: const Text('Add to cart',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,)))
          ],
        ),
      ),
    );
  }
}
