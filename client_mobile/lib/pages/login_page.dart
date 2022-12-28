import 'package:client_mobile/app.dart';
import 'package:client_mobile/helpers/api.dart';
import 'package:client_mobile/pages/motard/welcome_page.dart';
import 'package:client_mobile/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //
  var _obscureText = true;

  //
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  //
  Api api = Api();

  //
  mainFunction() async {
    await api.getCurrentUser().then((res) {
      if (res.statusCode == 200) {
        if (res.data['client']) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AppPage(),
            ),
          );
        } else if (res.data['motard']) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WelcomePage(),
            ),
          );
        }
      }
    });
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              const Text(
                'Sign-In',
                style: TextStyle(fontSize: 28.0),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.12),
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
                  onPressed: () {
                    api
                        .login(username.text.trim(), password.text.trim())
                        .then((res) async {
                      // print('Data are ${res.data}');
                      if (res.statusCode == 200) {
                        //
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        preferences.setString('token', res.data['key']);

                        //
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AppPage(),
                          ),
                        );
                      }
                    });
                    // api.fetchAssociation().then((value) {
                    //   print(value);
                    // });
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
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Not have a account? ',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Sign-up",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
