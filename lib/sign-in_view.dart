import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supe_restaurants/home_view.dart';
import 'sign-up_view.dart';
class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {

  final txtUsername = TextEditingController();
  final txtPassword = TextEditingController();

  String username = '';
  String password = '';
  String dataId = '';

  @override
  void initState() {
    // TODO: implement initState
    checkLogin();
    super.initState();
  }

  void checkLogin() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? val = preferences.getString("dataId");
    if(val!=null){
      if(val.isNotEmpty){
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context)=>HomeView()),
                (route) => false);
      }
    }

  }


void login(String username, String password) async{
    if( txtUsername.text.isNotEmpty && txtPassword.text.isNotEmpty){

      final res = await http.get(Uri.parse("https://probable-knowledgeable-zoo.glitch.me/users?username=$username&password=$password"));
      if(res.body.isNotEmpty){
       print(res.body);
       final body = jsonDecode(res.body);
       print(body[0]["id"]);
       pageRute(body[0]["id"].toString());
        /* SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString("token", body["token"]);
*/
      }else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(
            content:
            Text("Correo o Contraseña incorrectos")));
      }
    }else{
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
          content:
          Text('Valores incompletos')));
    }
  }
  void pageRute(String dataId) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("dataId",dataId);


    if(dataId.isNotEmpty){
      Navigator.push(
          context,MaterialPageRoute(builder: (context) => HomeView()));

    }
    else if(dataId.isEmpty){
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(
          content:
          Text(":c")));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text('Restaurants',
                  style: TextStyle(
                      fontSize: 45,
                    color: Colors.deepOrange
                  ),),
                Text('Sign In ',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black
                  ),),

                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: txtUsername,
                        obscureText: false,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nombre',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                           controller: txtPassword,
                          obscureText: true,
                          decoration: const InputDecoration(

                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red
                                )
                            ),
                            labelText: 'Contraseña',
                          )
                      ),
                    ],
                  ),
                ),
                ElevatedButton(onPressed: (){
                  setState(() {
                    username = txtUsername.text;
                    password = txtPassword.text;
                  });
                 login(username,password);

                }, child: Text('Login')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                      'Does not have account',
                    ),
                      TextButton(
                          onPressed: (){
                            Navigator.push(
                             context,MaterialPageRoute(builder: (context) => SignUpView()));
                          },
                          child: Text('Create Account?',style: TextStyle(

                              fontWeight: FontWeight.bold
                          ),)),

                    ],
                  ),

              ],
            ),
          ),

        ),
      ),
    );
  }
}
