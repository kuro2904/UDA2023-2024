import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:food_app/constants/backend_config.dart';
import 'package:food_app/data/delivery_man.dart';
import 'delivery_man_box_list.dart';
import 'add_update_delivery_man.dart';

class DeliveryMenPage extends StatefulWidget {
  const DeliveryMenPage({Key? key});

  @override
  State<StatefulWidget> createState() => DeliveryMenPageState();
}

class DeliveryMenPageState extends State<DeliveryMenPage> {
  late Future<List<DeliveryMan>> _futureDeliveryMen;

  @override
  void initState() {
    super.initState();
    _futureDeliveryMen = fetchAllDeliveryMen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Delivery Men',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'All Men',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const AddOrUpdateDeliveryManPage(),
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    child: const Text(
                      'Add new',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder(
                future: _futureDeliveryMen,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return DeliveryMenBoxList(snapshot.data ?? []);
                  } else {
                    return const Center(child: Text('No data available'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<DeliveryMan> parseDeliveryMan(String responseBody) {
  final parser = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parser.map<DeliveryMan>((json) => DeliveryMan.fromJson(json)).toList();
}

Future<List<DeliveryMan>> fetchAllDeliveryMen() async {
  final response =
      await http.get(Uri.parse(BackEndConfig.fetchAllDeliveryMenString));
  if (response.statusCode == 200) {
    return parseDeliveryMan(response.body);
  } else {
    throw Exception('Unable to fetch all Delivery Men');
  }
}
