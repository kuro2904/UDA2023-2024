import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/constants/backend_config.dart';
import 'package:food_app/data/client_state.dart';
import 'package:food_app/data/delivery_man.dart';
import 'package:http/http.dart' as http;

import 'delivery_men_management_page.dart';

class AddOrUpdateDeliveryManPage extends StatefulWidget {
  final DeliveryMan? deliveryMan;

  const AddOrUpdateDeliveryManPage({super.key, this.deliveryMan});

  @override
  State<StatefulWidget> createState() => AddOrUpdateDeliveryManState();
}

class AddOrUpdateDeliveryManState extends State<AddOrUpdateDeliveryManPage> {
  TextEditingController deliveryManId = TextEditingController();
  TextEditingController deliveryManName = TextEditingController();
  bool updateMode = false;

  @override
  void initState() {
    if (widget.deliveryMan != null) {
      deliveryManId.text = widget.deliveryMan!.id;
      deliveryManName.text = widget.deliveryMan!.name;
      updateMode = true;
    }
    super.initState();
  }

  Future<void> performInsert(String id, String name) async {
    Map<String, String> body = {'id': id, 'name': name};
    Map<String, String> header = {
      'Authorization': ClientState().token,
      'Content-Type': 'application/json'
    };
    var response = await http.post(
        Uri.parse(BackEndConfig.insertDeliveryManString),
        headers: header,
        body: jsonEncode(body));
    if (response.statusCode == 201) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const DeliveryMenPage()));
    }
  }

  Future<void> performUpdate(String name) async {
    Map<String, String> body = {'name': name};
    Map<String, String> header = {
      'Authorization': ClientState().token,
      'Content-Type': 'application/json'
    };
    var response = await http.put(
        Uri.parse(
            BackEndConfig.updateDeliveryManString + widget.deliveryMan!.id),
        headers: header,
        body: jsonEncode(body));
    if (response.statusCode == 200) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const DeliveryMenPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          updateMode ? 'Update Delivery Man' : 'Add Delivery Man',
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                              hintText: 'Delivery man Id'),
                          controller: deliveryManId,
                          enabled: updateMode ? false : true,
                        )),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Delivery man Name'),
                          controller: deliveryManName,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {
                          updateMode
                              ? performUpdate(deliveryManName.text)
                              : performInsert(
                                  deliveryManId.text, deliveryManName.text);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue)),
                        child: Text(
                          updateMode ? 'Update' : 'Add',
                          style: const TextStyle(color: Colors.white),
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
