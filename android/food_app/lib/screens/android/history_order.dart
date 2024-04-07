import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/constants/backend_config.dart';
import 'package:food_app/data/Order.dart';
import 'package:food_app/data/client_state.dart';
import 'package:http/http.dart' as http;

class HistoryOrderPage extends StatefulWidget {
  const HistoryOrderPage({super.key});

  @override
  State<StatefulWidget> createState() => HistoryOrderState();
}

class HistoryOrderState extends State<HistoryOrderPage> {
  late final Future<List<Order>> futureBill;

  @override
  void initState() {
    super.initState();
    futureBill = fetchAllOrder();
  }

  Future<List<Order>> fetchAllOrder() async {
    final response = await http.get(
      Uri.parse(
        BackEndConfig.fetchHistoryOrder + ClientState().userName,
      ),
      headers: ClientState().header,
    );
    if (response.statusCode == 200) {
      return parseAllOrder(response.body);
    } else {
      throw Exception('Unable to fetch History Order');
    }
  }

  List<Order> parseAllOrder(String responseString) {
    final parser = jsonDecode(responseString).cast<Map<String, dynamic>>();
    return parser.map<Order>((json) {
      return Order(
        json['id'],
        json['user_email'],
        json['discountId'] ?? 'No discount',
        cusAddress: json['cus_address'],
        cusPhone: json['cus_phone'],
        createDate: json['createDate'],
        paymentMethod: json['paymentMethod'],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: FutureBuilder<List<Order>>(
        future: futureBill,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error!: ${snapshot.error}'),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            final orders = snapshot.data!;
            if (orders.isEmpty) {
              return const Center(
                child: Text('No Orders'),
              );
            }
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Card(
                    elevation: 3,
                    child: ListTile(
                      title: Text(
                        'Order ID: ${order.id.replaceRange(20, order.id.length, '...')}',
                      ),
                      subtitle: Text('Date: ${order.createDate}'),
                      onTap: () {
                        // Implement onTap functionality
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text('No Data'),
            );
          }
        },
      ),
    );
  }
}
