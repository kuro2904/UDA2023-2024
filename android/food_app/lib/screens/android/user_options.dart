import 'package:flutter/material.dart';
import 'package:food_app/data/client_state.dart';
import 'package:food_app/screens/android/history_order.dart';
import 'package:food_app/screens/android/home_components/item_container.dart';

import '../login.dart';

class UserOptions extends StatefulWidget {
  const UserOptions({super.key});

  @override
  State<StatefulWidget> createState() => UserOptionState();
}

class UserOptionState extends State<UserOptions> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: ItemContainer(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HistoryOrderPage()));
              },
              height: 50,
              children: const [
                Text("History"),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: ItemContainer(
              onTap: () {
                setState(() {
                  final logOut = ClientState().logout();
                  if (logOut) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  }
                });
              },
              height: 50,
              children: const [
                Text("Log out"),
              ],
            ),
          ),
          if (ClientState().isAdmin())
            Container(
              padding: const EdgeInsets.all(8),
              child: ItemContainer(
                onTap: () {
                  Navigator.pop(context);
                },
                height: 50,
                children: const [
                  Text("Dashboard"),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
