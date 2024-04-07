import 'package:flutter/material.dart';
import 'package:food_app/data/product.dart';

import '../../../constants/backend_config.dart';

class ProductItem extends StatelessWidget {
  // TODO: Chỉ để test làm lại sau
  const ProductItem({
    super.key,
    required this.product,
    this.width = 150,
    this.height = 150,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.decoration,
    this.onTap,
  });

  final Product product;
  final double width, height;
  final Color backgroundColor, textColor;
  final Decoration? decoration;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      // NOTE: allow manipulate click action for each item instead of whole menu
      child: Container(
        width: width,
        height: height,
        decoration: decoration ??
            BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              "${BackEndConfig.fetchImageString}${product.imageUrl}",
              width: width * 0.7,
              height: height * 0.7,
            ),
            SizedBox(
              height: height / 20,
            ),
            Text(
              product.name,
              style: TextStyle(
                color: textColor,
                fontSize: height / 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
