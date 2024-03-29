import 'package:flutter/material.dart';

import '../../data/OrderDetail.dart';
import 'cart_components/cart_item.dart';

class CartPage extends StatefulWidget{
  List<OrderDetail> orderDetails;
  CartPage({super.key, required this.orderDetails});

  @override
  State<StatefulWidget> createState()=> CartPageState();
}

class CartPageState extends State<CartPage>{

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: ListView.builder(itemCount: widget.orderDetails.length ,itemBuilder: (context, index){
       return CartItem(item: widget.orderDetails[index],);
     })
   );
  }

}