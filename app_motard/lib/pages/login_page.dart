import 'dart:convert';

import 'package:app_motard/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //
  var _obscureText = true;

  //
  final String baseUrl = 'http://192.168.0.101:8000/api';

  //
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  //
  mainFunction() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token');
      await http.get(Uri.parse('http://192.168.0.101:8000'),
          headers: {'Authorization': 'token $token'}).then((res) {
        print(res);
        // if (res.statusCode == 200) {
        //   if (res.data['client']) {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => const AppPage(),
        //       ),
        //     );
        //   } else if (res.data['motard']) {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => const WelcomePage(),
        //       ),
        //     );
        //   }
        // }
      });
    } catch (e) {
      print(e);
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   mainFunction();
  // }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    super.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              const Text(
                'Sign-In',
                style: TextStyle(fontSize: 28.0),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.all(Radius.circular(25.7))),
                child: TextField(
                  controller: username,
                  style: const TextStyle(
                    fontSize: 13.0,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    labelStyle: TextStyle(
                      fontSize: 13.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50.0),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.all(Radius.circular(25.7))),
                child: TextField(
                  controller: password,
                  obscureText: _obscureText,
                  style: const TextStyle(
                    fontSize: 13.0,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(fontSize: 14.0),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),

              // Login button
              SizedBox(
                width: MediaQuery.of(context).size.width *
                    0.85, // Will take 85% of screen space
                child: ElevatedButton(
                  onPressed: () async {
                    await http.post(
                      Uri.parse('$baseUrl/auth/login/'),
                      body: {
                        'username': username.text,
                        'password': password.text
                      },
                    ).then((res) async {
                      print(res.body);
                      if (res.statusCode == 200 || res.statusCode == 201) {
                        print(username.text);
                        var resJson = json.decode(res.body);
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        preferences.setString('token', resJson['key']);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    primary: const Color.fromARGB(255, 31, 31, 339),
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                  ),
                  child: const Text(
                    'login',
                    style: TextStyle(
                      color: Color.fromRGBO(239, 233, 255, 1),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
