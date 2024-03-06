import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/data/client_state.dart';
import 'package:food_app/screens/admin/main_page.dart';
import 'package:food_app/screens/admin/register_admin.dart';

import '../../utils/dialog.dart';

class AdminLogin extends StatefulWidget{
  const AdminLogin({super.key});

  @override
  State<StatefulWidget> createState() => AdminLoginState();
}

class AdminLoginState extends State<AdminLogin>{

  TextEditingController emailControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text('Login',style: TextStyle(
                fontSize: 40, fontWeight: FontWeight.bold
              ),),
            ),
            const SizedBox(height: 40,),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
              ),
              controller: emailControl,
            ),
            const SizedBox(height: 20,),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
              ),
              obscureText: true,
              controller: passwordControl,
            ),
            const SizedBox(height: 20,),
            Center(
              child: TextButton(
                onPressed: (){
                  setState(() {
                    _loginAdmin(context,emailControl.text,passwordControl.text);
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  fixedSize: MaterialStateProperty.all<Size>(const Size.fromWidth(300))
                ),
                 child: const Text('Login', style: TextStyle(color: Colors.white),),
              ),
            ),
            const SizedBox(height: 20,),
            Center(
              child: TextButton(
                onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpAdminPage()));
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    fixedSize: MaterialStateProperty.all<Size>(const Size.fromWidth(300))
                ),
                child: const Text('Sign Up', style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        ),
      )
    );
  }
}

_loginAdmin(BuildContext context, String email, String password) async{
  final login = await ClientState().login(email, password);
  if(login){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const MyAdmin()));
  }else{
    showAlertDialog(context, ClientState().serverMessage, "Login failed");
  }
}