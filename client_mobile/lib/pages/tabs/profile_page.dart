// ignore_for_file: use_build_context_synchronously

import 'package:client_mobile/helpers/api.dart';
import 'package:client_mobile/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //
  Api api = Api();

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(child: Text('Profil')),
          const SizedBox(
            height: 80,
          ),
          ElevatedButton(
            onPressed: () async {
              print('start logout');
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.remove('token');
              preferences.remove('userId');
              print('Logout');
              //
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
              // Navigator.of(context).pop();
              // api.logout().then((res) {
              //   print('Logout');
              //   Navigator.of(context).pop();
              // });
            },
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              primary: const Color.fromARGB(255, 223, 49, 29),
              padding: const EdgeInsets.only(
                  top: 15, bottom: 15, left: 80, right: 80),
            ),
            child: const Text(
              'Deconnecter',
              style: TextStyle(
                color: Color.fromRGBO(239, 233, 255, 1),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
