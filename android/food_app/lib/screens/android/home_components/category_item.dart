import 'package:flutter/material.dart';
import 'package:food_app/constants/backend_config.dart';

import '../../../../data/category.dart';

class CategoryItem extends StatelessWidget{
  const CategoryItem({
    super.key,
    required this.category,
    this.width = 150,
    this.height = 150,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.decoration,
    this.onTap,
  });

  final Category category;
  final double width, height;
  final Color backgroundColor, textColor;
  final Decoration? decoration;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // NOTE: allow manipulate click action for each item instead of whole menu
      child: Container(
        width: width,
        height: height,
        decoration: decoration ?? BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              "${BackEndConfig.fetchImageString}${category.imageUrl}",
              width: width * 0.7,
              height: height * 0.7,
            ),
            SizedBox(height: height / 20,),
            Text(
              category.name,
              style: TextStyle(
                color: textColor,
                fontSize: height / 8,
              ),
            ),
          ],
        ),
      ),
    );
  }

}