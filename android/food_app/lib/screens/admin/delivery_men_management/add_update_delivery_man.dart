import 'package:flutter/material.dart';
import 'package:food_app/data/delivery_man.dart';
import 'package:food_app/screens/admin/delivery_men_management/delivery_men_management_page.dart';


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
                          enabled: updateMode? false : true,
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
                        onPressed: () async {
                          bool result = false;
                          if (updateMode) {
                            result = await DeliveryMan.update(widget.deliveryMan!.id, deliveryManName.text);
                          } else {
                            result = await DeliveryMan.insert(deliveryManId.text, deliveryManName.text);
                          }
                          if (result) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const DeliveryMenPage()));
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue)),
                        child: Text(
                          updateMode? 'Update' : 'Add',
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


