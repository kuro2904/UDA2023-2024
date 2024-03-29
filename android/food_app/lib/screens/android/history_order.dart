
import 'package:flutter/material.dart';
import 'package:food_app/data/Order.dart';

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
    futureBill = Order.fetchAll();
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
