import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/data/client_state.dart';
import 'package:food_app/data/payment_method.dart';
import 'package:food_app/utils/dialog.dart';
import 'package:http/http.dart' as http;
import '../../constants/backend_config.dart';
import '../../data/discount.dart';

class Bill extends StatefulWidget {
  const Bill({super.key});

  @override
  State<StatefulWidget> createState() => BillState();
}

class BillState extends State<Bill> {
  TextEditingController cusPhoneController = TextEditingController();
  TextEditingController cusAddressController = TextEditingController();
  PaymentMethod paymentMethod = PaymentMethod.COD;
  late Future<List<Discount>> futureDiscount;
  Discount? selectedDiscount;

  @override
  void initState() {
    futureDiscount = fetchAllDiscounts();
    super.initState();
  }
  
  performPlaceOrder(String cusPhone, String cusAddress, PaymentMethod paymentMethod, Discount? discount) async{
    Uri url = Uri.parse(BackEndConfig.placeOrderString);
    Map<String, dynamic> body = {
      'cus_phone': cusPhone,
      'cus_address': cusAddress,
      'paymentMethod': paymentMethod.name,
      'discountId': discount?.id.toString(),
      'createDate': DateTime.now().toString(),
      'status': 'REQUEST',
      'details': ClientState().cart
    };
    var response = await http.post(url,headers: ClientState().header,body: jsonEncode(body));
    if(response.statusCode == 201){
      Navigator.pop(context);
      showAlertDialog(context, 'Bill total: \n${response.body}', 'Place Order Successful!');
    }else{
      Navigator.pop(context);
      showAlertDialog(context, 'Status code: ${response.statusCode}', 'Error!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: cusPhoneController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Phone number'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: cusAddressController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Address'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(8, 15, 8, 8),
              child: Text(
                'Payment Method:',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 50,
                child: DropdownButton<PaymentMethod>(
                  value: paymentMethod,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: PaymentMethod.values.map((paymentMethod) {
                    return DropdownMenuItem(
                      value: paymentMethod,
                      child: Center(child: Text(paymentMethod.name,),),
                    );
                  }).toList(),
                  style: const TextStyle(
                    color: Colors.black, // Text color
                    fontSize: 16, // Text size
                    fontWeight: FontWeight.bold, // Text weight
                  ),
                  dropdownColor: Colors.grey[200],
                  elevation: 8,
                  isExpanded: true,
                  onChanged: (PaymentMethod? value) {
                    setState(() {
                      paymentMethod = value!;
                    });
                  },
                ),
              ),
            ),
            FutureBuilder(
                future: futureDiscount,
                builder: (context, snapshot) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData &&
                      snapshot.data!.isEmpty) {
                    return const Text('No Discount available');
                  } else {
                    selectedDiscount = snapshot.data!.first;
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        height: 50,
                        child: DropdownButton<Discount>(
                          value: selectedDiscount,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: snapshot.data!.map((discount) {
                            return DropdownMenuItem(value: discount,child: Text(discount.id),);
                          }).toList(),
                          style: const TextStyle(
                            color: Colors.black, // Text color
                            fontSize: 16, // Text size
                            fontWeight: FontWeight.bold, // Text weight
                          ),
                          dropdownColor: Colors.grey[200],
                          elevation: 8,
                          isExpanded: true,
                          onChanged: (Discount? value) { setState(() {
                            selectedDiscount = value!;
                          }); },
                        ),
                      ),
                    );
                  }
                }),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)
                ),
                    child: const Text('Cancel!', style: TextStyle(color: Colors.white),)),
                TextButton(onPressed: (){
                  performPlaceOrder(cusPhoneController.text, cusAddressController.text, paymentMethod,selectedDiscount);
                }, style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue)
                ),
                    child: const Text('Place Order!', style: TextStyle(color: Colors.white))),
              ],
            )
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