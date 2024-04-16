import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/constants/backend_config.dart';
import 'package:food_app/data/client_state.dart';
import 'package:food_app/data/discount.dart';
import 'package:food_app/screens/admin/discount_management/discount_management_page.dart';
import 'package:http/http.dart' as http;

class AddDiscountPage extends StatefulWidget {
  const AddDiscountPage({Key? key});

  @override
  State<StatefulWidget> createState() => AddDiscountPageState();
}

class AddDiscountPageState extends State<AddDiscountPage> {
  TextEditingController discountId = TextEditingController();
  TextEditingController discountPercent = TextEditingController();
  TextEditingController discountStartDate = TextEditingController();
  TextEditingController discountExpiredDate = TextEditingController();
  late Future<List<Discount>> futureDiscounts;
  final _onlyNumbersFormatter = FilteringTextInputFormatter.digitsOnly;

  @override
  void initState() {
    futureDiscounts = fetchAllDiscounts();
    super.initState();
  }

  Future<void> performInsert(String id, int discountPercent, String startDate,
      String expiredDate) async {
    final Map<String, dynamic> body = {
      'id': id,
      'discount_percent': discountPercent,
      'start_date': startDate,
      'expire_date': expiredDate
    };
    final Map<String, String> header = {
      'Authorization': ClientState().token,
      'Content-Type': 'application/json'
    };
    final Uri url = Uri.parse(BackEndConfig.insertDiscountString);
    final response =
        await http.post(url, headers: header, body: jsonEncode(body));
    if (response.statusCode == 201) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DiscountPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Discount',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Discount Id',
                  ),
                  controller: discountId,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Discount Percent',
                  ),
                  controller: discountPercent,
                  inputFormatters: [_onlyNumbersFormatter],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Start Date',
                  ),
                  controller: discountStartDate,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Expired Date',
                  ),
                  controller: discountExpiredDate,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    performInsert(
                      discountId.text,
                      int.tryParse(discountPercent.text) ??
                          0, // Parse and handle null values
                      discountStartDate.text,
                      discountExpiredDate.text,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
