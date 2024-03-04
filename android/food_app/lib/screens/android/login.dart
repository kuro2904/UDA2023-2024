import 'package:flutter/material.dart';
import 'package:food_app/Utils/dialog.dart';
import 'package:food_app/Utils/network.dart';
import 'package:food_app/constants/backend_config.dart';
import 'package:food_app/data/client_state.dart';
import 'package:food_app/screens/android/signup.dart';
import 'package:food_app/theme/theme.dart';
import 'package:icons_plus/icons_plus.dart';

// for testing remove later
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
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  bool loginPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            const Text(
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
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
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
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
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
                    const Text(
                      "Remember me",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: passwordForgot,
                  child: const Text(
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
              onPressed: loginPressed ? null : login,
              child: Text(
                loginPressed ? "Logging in" : "Login",
                style: const TextStyle(
                    fontSize: 18
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: loginPressed ? null : () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignUpPage()
                    )
                );
                if (ClientState().isLogin) Navigator.pop(context);
              },
              child: const Text(
                "Sign up",
                style: TextStyle(
                    fontSize: 18
                ),
              ),
            ),
            const Padding(
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
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: googleLogin,
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                    ),
                    child: Brand(Brands.google),
                  ),
                ],
              ),
            ),
            const Spacer(), // Spacing
            Center(
              child: ElevatedButton( // Nút quay lại
                onPressed: loginPressed ? null : () {
                  Navigator.pop(context); // Quay lại screen trước đó
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                ),
                child: const Icon(Icons.close),
              ),
            )
          ],
        ),
      ),
    );
  }

  googleLogin() {
    // TODO: google login
  }

  login() async {
    if (ClientState().isLogin) return;

    if (nameController.text.isEmpty ||
        passwordController.text.isEmpty) {
      showAlertDialog(context, "User name and password cannot be empty", "Login failed");
      return;
    }

    setState(() {
      loginPressed = true;
    });

    final login = await ClientState().login(nameController.text, passwordController.text);

    if (login == false) {
      setState(() {
        loginPressed = false;
      });
      showAlertDialog(context, ClientState().serverMessage, "Login failed");
    }
    else {
      Navigator.pop(context);
    }
  }

  passwordForgot() {
    // TODO: password forgot
  }

}