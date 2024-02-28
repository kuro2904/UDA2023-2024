import 'package:flutter/material.dart';

import '../../../data/category.dart';


class CategoryItem extends StatelessWidget{
  const CategoryItem({
    super.key,
    required this.category,
    this.width = 150,
    this.height = 150,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.decoration,
  });

  final Category category;
  final double width, height;
  final Color backgroundColor, textColor;
  final Decoration? decoration;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {}, // TODO: Chuyển đến trang category tương ứng
      child: Container(
        width: width,
        height: height,
        decoration: decoration ?? BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              category.imageUrl,
              width: width * 0.7,
              height: height * 0.7,
            ),
            SizedBox(height: height / 20,),
            Text(
              category.name,
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