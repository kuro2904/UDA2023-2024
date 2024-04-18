import 'package:flutter/material.dart';
import 'package:food_app/data/client_state.dart';
import 'package:food_app/screens/android/android_main.dart';
import 'package:food_app/screens/android/bill_page.dart';
import 'package:food_app/screens/android/detailProduct.dart';
import 'package:food_app/utils/dialog.dart';

import '../../data/OrderDetail.dart';
import 'cart_components/cart_item.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => CartPageState();
}

class CartPageState extends State<CartPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: ClientState().cart.length,
              itemBuilder: (context, index) {
                return CartItem(
                  orderDetail: ClientState().cart[index],
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                          ProductDetail(
                            product: ClientState().cart[index].product,
                            inCartId: index,
                            selectedTopping: ClientState().cart[index].toppings,
                            selectedPrice: ClientState().cart[index].selectionPrice,
                          )
                      )
                    );
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AndroidMain(selectedIndex: 1,)));
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      ClientState().clearCart();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    'Clear Cart',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (ClientState().cart.isEmpty) {
                      showAlertDialog(context, "Bạn phải chọn it nhất 1 sản phẩm để thanh toán", "Giỏ hàng trống");
                      return;
                    }
                    final returnCode = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Bill()),
                    );
                    if (returnCode == 'ok') {
                      setState(() {
                        ClientState().clearCart();
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    'Place Order',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
