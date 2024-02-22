
import 'package:flutter/cupertino.dart';
import '../../data/category.dart';

class CategoryItem extends StatelessWidget{
  final Category category;
  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Image.network(category.imageUrl)
    );
  }

}