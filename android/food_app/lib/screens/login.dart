import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_app/constants/backend_config.dart';
import 'package:food_app/data/client_state.dart';
import 'package:food_app/screens/admin/dashboard_page.dart';
import 'package:food_app/screens/android/android_main.dart';
import 'package:food_app/screens/android/home.dart';
import 'package:food_app/screens/android/sign_up_page.dart';
import 'package:http/http.dart' as http;


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Food App',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                ),
              ),
            ),

            const SizedBox(height: 20),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: (_loading) ? null : _login,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)
              ),
              child: _loading ? const CircularProgressIndicator() : const Text('Login'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                  },
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _login() async {
    final username = nameController.text;
    final password = passwordController.text;

    var body = {
      'email': username,
      'password': password
    };

    var header = {
      'Content-Type': 'application/json'
    };

    setState(() {
      _loading = true;
    });

    try {
      Uri url = Uri.parse(BackEndConfig.loginString);
      var response = await http.post(url,body: jsonEncode(body), headers: header);
      if(response.statusCode == 200 ){
        var parser = json.decode(response.body);
        ClientState().userName = parser['email'];
        ClientState().role = parser['role'];
        ClientState().userPassword = parser['password'];
        ClientState().isLogin = true;
        ClientState().token = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
        ClientState().header.addEntries({'Authorization': ClientState().token}.entries);
        if(ClientState().role == 'ROLE_CUSTOMER'){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AndroidMain()));
        }else{
          Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardPage()));
        }
      }
    } catch (e) {
      print(e); // TODO: call some log function
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

}
