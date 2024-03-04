import 'package:flutter/material.dart';
import 'package:food_app/utils/dialog.dart';
import 'package:food_app/data/client_state.dart';
import 'package:food_app/screens/android/login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return SignUpPageState();
  }
}

class SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  bool isAgreed = false;
  bool buttonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const Center(
            child: Text('Sign Up',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50.0))),
                      hintText: 'Name',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(50.0))),
                        hintText: 'Password',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: TextField(
                      controller: phoneNumberController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(50.0))),
                        hintText: 'phone number',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: TextField(
                      controller: addressController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(50.0))),
                        hintText: 'address',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: isAgreed,
                          onChanged: (bool? newValue) {
                            setState(() {
                              isAgreed = !isAgreed;
                            });
                          },
                        ),
                        const Text('Agree our Term of service and Privacy Policy')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: TextButton(
                      onPressed: buttonPressed ? null : signup,
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(double.infinity, 50)),
                      ),
                      child: Text(
                        buttonPressed ? 'Registering' : 'Sign Up',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding:const EdgeInsets.only(bottom: 10),
            child: Center(
                child: GestureDetector(
                  onTap: buttonPressed ? null : () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()
                        )
                    );
                    if (ClientState().isLogin) Navigator.pop(context);
                  },
                  child: const Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.black),
                  ),
                )
            ),
          ),
          Padding(
            padding:const EdgeInsets.only(bottom: 40),
            child: Center(
                child: GestureDetector(
                  onTap: buttonPressed ? null : () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close),
                )
            ),
          ),
        ],
      ),
    );
  }

  signup() async {
    if (isAgreed == false) {
      showAlertDialog(context, "You have to agree with our Term of service and Privacy Policy", "Register failed");
      return;
    }

    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        phoneNumberController.text.isEmpty ||
        addressController.text.isEmpty) {
      showAlertDialog(context, "You have to fill all of the text fields", "Register failed");
      return;
    }

    setState(() {
      buttonPressed = true;
    });

    final response = await ClientState().signup(emailController.text, passwordController.text, phoneNumberController.text, addressController.text);

    if (response == false) {
      setState(() {
        buttonPressed = false;
      });
      showAlertDialog(context, ClientState().serverMessage, "Register failed");
    }
    else {
      Navigator.pop(context);
    }
  }
}
