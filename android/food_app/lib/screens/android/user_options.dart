import 'package:flutter/material.dart';
import 'package:food_app/data/client_state.dart';
import 'package:food_app/screens/android/history_order.dart';
import 'package:food_app/screens/android/home_components/item_container.dart';
import 'package:food_app/screens/android/login.dart';

import 'android_main.dart';

class UserOptions extends StatelessWidget {
  const UserOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final parentState = context.findAncestorStateOfType<AndroidMainState>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (ClientState().isLogin)
            Container(
              padding: const EdgeInsets.all(8),
              child: ItemContainer(
                onTap: () {
                  // TODO: Đến trang thông tin cá nhân
                },
                height: 50,
                children: const [
                  Text("Profile"),
                ],
              ),
            ),
          if (ClientState().isLogin)
            Container(
              padding: const EdgeInsets.all(8),
              child: ItemContainer(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryOrderPage(),));
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
                  if (ClientState().logout()) {
                    parentState?.onItemTapped(0);
                  }
                },
                height: 50,
                children: const [
                  Text("Log out"),
                ],
              ),
            ),
          if (ClientState().isLogin == false)
            Container(
              padding: const EdgeInsets.all(8),
              child: ItemContainer(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage()
                    )
                  );
                  if (ClientState().isLogin) {
                    parentState?.onItemTapped(0);
                  }
                },
                height: 50,
                children: const [
                  Text("Log in"),
                ],
              ),
            ),
        ],
      ),
    );
  }
}