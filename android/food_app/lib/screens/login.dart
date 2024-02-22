import 'package:flutter/material.dart';
import 'package:food_app/theme/theme.dart';
import 'package:icons_plus/icons_plus.dart';

// for testing rmove later
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Login Page',
//       home: Scaffold(
//         body: const LoginPage(),
//       )
//     );
//   }
// }
//

class LoginPage extends StatefulWidget  {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Text(
            "Login",
            style: TextStyle(
              fontSize: 30,
              color: Colors.blue,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: TextField(
              controller: nameController,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                labelText: "UserName:",
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                  labelText: "Password:",
                  labelStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  )
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: rememberMe,
                    onChanged: (bool? value) {
                      setState(() {
                        rememberMe = value!;
                      });
                    },
                    activeColor: lightColorScheme.primary,
                  ),
                  Text(
                    "Remember me",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: PasswordForgot,
                child: Text(
                  "Forget Password?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: Login,
            child: Text(
              "Login",
              style: TextStyle(
                fontSize: 18
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
            child: Row(
              children: <Widget>[
                Expanded(child: Divider()),
                Text("Or"),
                Expanded(child: Divider()),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: GoogleLogin,
                  child: Brand(Brands.google),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  GoogleLogin() {
    // TODO: google login
  }

  Login() {
    // TODO: Login logic
  }

  PasswordForgot() {
    // TODO: password forgot
  }

}