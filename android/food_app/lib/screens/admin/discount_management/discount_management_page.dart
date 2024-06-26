import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constants/backend_config.dart';

import 'package:food_app/screens/admin/discount_management/discount_add.dart';
import 'package:food_app/screens/admin/discount_management/discount_box_list.dart';
import 'package:http/http.dart' as http;
import '../../../data/discount.dart';

class DiscountPage extends StatefulWidget {
  const DiscountPage({super.key});

  @override
  State<StatefulWidget> createState() => DiscountManagementState();
}

class DiscountManagementState extends State<DiscountPage> {
  late Future<List<Discount>> _futureDiscounts;

  @override
  void initState() {
    super.initState();
    _futureDiscounts = fetchAllDiscounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Discount',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'All Discount',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddDiscountPage()));
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue)),
                    child: const Text(
                      'Add new',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                )
              ],
            ),
            FutureBuilder(
              future: _futureDiscounts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData && snapshot.data != null) {
                  return DiscountBoxList(snapshot.data ?? []);
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

List<Discount> parseAllDiscount(String responseBody) {
  final parser = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parser.map<Discount>((json) => Discount.fromJson(json)).toList();
}

Future<List<Discount>> fetchAllDiscounts() async {
  final response =
      await http.get(Uri.parse(BackEndConfig.fetchAllDiscountString));
  if (response.statusCode == 200) {
    return parseAllDiscount(response.body);
  } else {
    throw Exception('Unable to fetch all Discount');
  }
}
