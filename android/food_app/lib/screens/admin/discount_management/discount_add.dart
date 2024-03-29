import 'package:flutter/material.dart';
import 'package:food_app/data/discount.dart';
import 'package:food_app/screens/admin/discount_management/discount_management_page.dart';

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
    futureDiscounts = Discount.fetchAll();
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
                        onPressed: () async {
                            final result = await Discount.insert(
                                discountId.text,
                                int.parse(discountPercent.text),
                                discountStartDate.text,
                                discountExpiredDate.text
                            );
                            if (result) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const DiscountPage()));
                            }
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
