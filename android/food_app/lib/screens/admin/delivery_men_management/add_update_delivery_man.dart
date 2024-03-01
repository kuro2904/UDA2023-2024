
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/data/delivery_man.dart';

import '../../../utils/authentication_generate_token.dart';


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
    if(widget.deliveryMan != null){
      deliveryManId.text = widget.deliveryMan!.id;
      deliveryManName.text = widget.deliveryMan!.name;
      updateMode = true;
    }
    super.initState();
  }

  @override
  void dispose() {
    deliveryManId.dispose();
    deliveryManName.dispose();
    super.dispose();
  }

  performUpdate(String id, String name){
    BasicAuthGenerateToken generateToken = BasicAuthGenerateToken("owner", "owner");
    Map<String, String> header = {
      'Authorization': generateToken.generateToken(),
      'Content-Type': 'application/json; charset=UTF-8'
    };
    Map<String,String> body = {
      'id':id,
      'name':name
    };

  }
  performInsert(String id, String name){}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          updateMode == true ? 'Update Delivery Man' : 'Add Delivery Man',
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
                              hintText: 'Product Id'),
                          controller: deliveryManId,
                        )),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Product Name'),
                          controller: deliveryManName,
                        )),

                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: (){
                          updateMode == false? performInsert(deliveryManId.text, deliveryManName.text) : performUpdate(deliveryManId.text, deliveryManName.text);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue)),
                        child: Text(
                          updateMode == true ? 'Update' : 'Add',
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


