import 'package:flutter/cupertino.dart';

import '../../../data/category.dart';

class CategoryBoxList extends StatelessWidget{
  final List<Category> items;
  const CategoryBoxList(this.items, {super.key});
  
  @override
  Widget build(BuildContext context) {
   return SizedBox(
     width: MediaQuery.sizeOf(context).width,
     height: 20,
     child: ListView.custom(childrenDelegate: SliverChildBuilderDelegate((context, index) {
       return Row(
         children: [
           Image.network(items[index].imageUrl,height: 18,width: 18,fit: BoxFit.contain),
           Text(items[index].name, style: const TextStyle(fontSize: 15))
         ],
       );
     },childCount: items.length))
   );
  }

}