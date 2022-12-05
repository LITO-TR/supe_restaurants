import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'sign-in_view.dart';
class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {

  final txtFirstName = TextEditingController();
  final txtLastName = TextEditingController();
  final txtUsername = TextEditingController();
  final txtPassword = TextEditingController();


  String firstName = '';
  String lastName ='';
  String username = '';
  String password ='';

  void register() async {
    final user = {
      "username": username,
      "last_name": lastName,
      "first_name": firstName,
      "password": password,
    };

    final headers = {"Content-Type": "application/json;charset=UTF-8"};

    final res = await http.post(Uri.parse("https://probable-knowledgeable-zoo.glitch.me/users"),
        headers: headers, body: jsonEncode(user));
    print(res);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true ,
        title:  Text('Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SafeArea(

            child: SingleChildScrollView(

              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),


                  TextField(
                    controller: txtFirstName,
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'First name',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  TextField(
                    controller: txtLastName,
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Last name',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  TextField(
                    controller: txtUsername,
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  TextField(
                    controller: txtPassword,
                    obscureText: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      onPressed: (){
                        setState(() {
                          firstName = txtFirstName.text;
                          lastName=txtLastName.text ;
                          username=txtUsername.text;
                          password = txtPassword.text;

                        });
                        register();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                            content:
                            Text("Registrado")));
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>SignInView()), (route) => false);

                      },
                      child: Text('Registrarse'))
                ],
              ),

            )

        ),
      ),
    );
  }
}
