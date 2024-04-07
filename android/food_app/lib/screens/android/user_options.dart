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
          if (ClientState().isLogin)
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
          if (ClientState().isLogin)
            Container(
              padding: const EdgeInsets.all(8),
              child: ItemContainer(
                onTap: () {
                    setState(() {
                      ClientState().logout();
                    });
                },
                height: 50,
                children: const [
                  Text("Log out"),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
