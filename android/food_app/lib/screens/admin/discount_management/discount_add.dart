import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constants/backend_config.dart';
import 'package:food_app/data/discount.dart';
import 'package:food_app/screens/admin/discount_management/discount_management_page.dart';
import 'package:food_app/utils/authentication_generate_token.dart';
import 'package:http/http.dart' as http;

class AddDiscountPage extends StatefulWidget {
  const AddDiscountPage({super.key});

  @override
  State<StatefulWidget> createState() => AddOrUpdateProductState();
}

class AddOrUpdateProductState extends State<AddDiscountPage> {
  TextEditingController discountId = TextEditingController();
  TextEditingController discountPercent = TextEditingController();
  TextEditingController discountStartDate = TextEditingController();
  TextEditingController discountExpiredDate = TextEditingController();
  late Future<List<Discount>> futureDiscounts;

  @override
  void initState() {
    futureDiscounts = fetchAllDiscounts();
    super.initState();
  }

  @override
  void dispose() {
    discountId.dispose();
    discountPercent.dispose();
    discountStartDate.dispose();
    discountExpiredDate.dispose();
    super.dispose();
  }

  Future<void> performInsert(String id, int discountPercent, String startDate,
      String expiredDate) async {
    BasicAuthGenerateToken generateToken = BasicAuthGenerateToken("owner", "owner");
    Map<String, String> header = {
      'Authorization': generateToken.generateToken(),
      'Content-Type':'application/json; charset=UTF-8'
    };
    Map<String,dynamic> body = {
      'id': id,
      'discount_percent': discountPercent,
      'start_date': startDate,
      'expire_date':expiredDate
    };
    Uri url = Uri.parse(BackEndConfig.insertDiscountString);
    var response = await http.post(url,headers: header, body: jsonEncode(body));
    if(response.statusCode == 201){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const DiscountPage()));
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
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Discount Id'),
                          controller: discountId,
                        )),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Discount Percent'),
                          controller: discountPercent,
                        )),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Start Date'),
                          controller: discountStartDate,
                        )),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Expired Date',
                          ),
                          controller: discountExpiredDate,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: (){
                          performInsert(discountId.text, int.parse(discountPercent.text),discountStartDate.text, discountExpiredDate.text);
                          },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue)),
                        child: const Text(
                          'Add',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
