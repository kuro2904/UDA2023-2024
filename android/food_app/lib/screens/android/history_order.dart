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
    Map<String, String> query = {'userEmail': ClientState().userName};
    Uri baseUrl =
        Uri.parse(BackEndConfig.fetchHistoryOrder + ClientState().userName);
    Uri url = baseUrl.replace(queryParameters: query);

    final response = await http.get(url, headers: ClientState().header);
    if (response.statusCode == 200) {
      print(response.body);
      return parseAllOrder(response.body);
    } else {
      throw Exception('Unable to fetch History Order');
    }
  }

  List<Order> parseAllOrder(String responseString) {
    final parser = jsonDecode(responseString).cast<Map<String, dynamic>>();
    return parser
        .map<Order>((json) => Order(
            json['id'], json['user_email'], json['discountId'] ?? 'No discount',
            cusAddress: json['cus_address'],
            cusPhone: json['cus_phone'],
            createDate: json['createDate'],
            paymentMethod: json['paymentMethod']))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: futureBill,
        builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error!: \n ${snapshot.error}'),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            List<Order> orders = snapshot.data!;
            if (orders.isEmpty) {
              return const Center(
                child: Text('No Data!'),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Id: ${orders[index].id.replaceRange(20, orders[index].id.length, '...')}'),
                        Text('Date ${orders[index].createDate}')
                      ],
                    ),
                  ),
                );
              },
              itemCount: orders.length,
            );
          } else {
            return const Center(
              child: Text('No Data!'),
            );
          }
        },
      ),
    );
  }

}
