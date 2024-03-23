import 'package:flutter/material.dart';
import 'package:food_app/data/client_state.dart';
import 'package:food_app/screens/android/bill_page.dart';
import '../../data/OrderDetail.dart';
import 'cart_components/cart_item.dart';

class CartPage extends StatefulWidget {
  List<OrderDetail> orderDetails;

  CartPage({super.key, required this.orderDetails});

  @override
  State<StatefulWidget> createState() => CartPageState();
}

class CartPageState extends State<CartPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
          Expanded(
              child: ListView.builder(
                  itemCount: widget.orderDetails.length,
                  itemBuilder: (context, index) {
                    return CartItem(
                      item: widget.orderDetails[index],
                    );
                  })),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            TextButton(
              onPressed: () {
                setState(() {
                  ClientState().cart.clear();
                });
              },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40))),
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              child: const Text(
                'Clear Cart',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Bill()));
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40))),
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              child: const Text('Place Order',
                  style: TextStyle(color: Colors.white)),
            )
          ])
                ],
              ),
        ));
  }
}

