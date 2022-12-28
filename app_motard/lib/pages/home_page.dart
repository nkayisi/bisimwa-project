import 'dart:async';
import 'dart:convert';
import 'package:app_motard/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //
  final String baseUrl = 'http://192.168.0.101:8000/api';

  //
  @override
  void initState() {
    super.initState();
    refresh();
    getCurrentUser();
  }

  bool enAttente = true;

  String status = 'En courss';
  var course = {};
  var motard = {};

  //
  LocationPermission? permission;

  //
  Future getCurrentUser() async {
    //
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token');

    await http.get(Uri.parse('$baseUrl/auth/user/')).then((res) async {
      var resJson = json.decode(res.body);
      await http
          .get(Uri.parse('$baseUrl/motard/${resJson['id']}/'))
          .then((res) {
        setState(() {
          motard = json.decode(res.body);
        });
      });
    });
  }

  Future<void> refresh() async {
    //
    await http.get(Uri.parse('$baseUrl/course/')).then((res) {
      if (res.statusCode == 200) {
        var resJson = json.decode(res.body).last;
        setState(() {
          status = resJson['statut'];
          course = resJson;
        });
        print(course['statut']);
      }
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: refresh,
          child: ListView(
            children: [
              status == 'En demande'
                  ? Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.13,
                        ),
                        const Card(
                          elevation: 0,
                          color: Color.fromARGB(78, 1, 173, 90),
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              'Hey ! un client vous a fait une demande de course !',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.green),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                        const Text(
                          'Demande en cours... !',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.height * 0.24,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    //
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    var token = preferences.getString('token');
                                    await http.delete(
                                      Uri.parse(
                                          '$baseUrl/course/${course['id']}/'),
                                      headers: {
                                        'Authorization': 'token $token'
                                      },
                                    ).then((res) {
                                      print(res.statusCode);
                                      if (res.statusCode == 200) {
                                        setState(() {
                                          status = 'Finis';
                                        });
                                      }
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                    primary: Colors.redAccent,
                                    padding: const EdgeInsets.only(
                                        top: 15, bottom: 15),
                                  ),
                                  child: const Text(
                                    'Anuller',
                                    style: TextStyle(
                                      color: Color.fromRGBO(239, 233, 255, 1),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.height * 0.24,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    //
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    var token = preferences.getString('token');
                                    await http.patch(
                                        Uri.parse(
                                            '$baseUrl/course/${course['id']}/'),
                                        headers: {
                                          'Authorization': 'token $token'
                                        },
                                        body: {
                                          'id': course['id'].toString(),
                                          'date': course['date'],
                                          'type': course['type'],
                                          'statut': 'En cours',
                                          'motard': course['motard']['user']
                                                  ['id']
                                              .toString(),
                                          'client': course['client']['user']
                                                  ['id']
                                              .toString(),
                                          'description': course['description']
                                        }).then((res) {
                                      print(res.statusCode);
                                      if (res.statusCode == 200) {
                                        setState(() {
                                          status = 'En cours';
                                        });
                                      }
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                    primary: Colors.green,
                                    padding: const EdgeInsets.only(
                                        top: 15, bottom: 15),
                                  ),
                                  child: const Text(
                                    'Accepter',
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
                        )
                      ],
                    )
                  : status == 'En cours'
                      ? Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.16,
                            ),
                            const Text(
                              'Course en cours... !',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.18,
                            ),
                            Text('Type de la course : ${course['type']}'),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Chip(
                              label: Text(
                                'Client : ${course['client']['nom']} ${course['client']['post_nom']} ${course['client']['prenom']}',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.2,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.height *
                                        0.24,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        permission = await Geolocator
                                            .requestPermission();
                                        //
                                        SharedPreferences preferences =
                                            await SharedPreferences
                                                .getInstance();
                                        var token =
                                            preferences.getString('token');
                                        // LOCATION
                                        // =============
                                        Position position =
                                            await Geolocator.getCurrentPosition(
                                                desiredAccuracy:
                                                    LocationAccuracy.high);
                                        print(position);
                                        http.post(
                                          Uri.parse("$baseUrl/alerte/"),
                                          headers: {
                                            'Authorization': 'token $token'
                                          },
                                          body: {
                                            'longitude':
                                                position.longitude.toString(),
                                            'latitude':
                                                position.latitude.toString(),
                                            'course': course['id'].toString(),
                                            'utilisateur': course['client']
                                                    ['user']['id']
                                                .toString()
                                          },
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: const StadiumBorder(),
                                        primary: Colors.redAccent,
                                        padding: const EdgeInsets.only(
                                            top: 15, bottom: 15),
                                      ),
                                      child: const Text(
                                        'Alerter',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(239, 233, 255, 1),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.height *
                                        0.24,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        //
                                        SharedPreferences preferences =
                                            await SharedPreferences
                                                .getInstance();
                                        var token =
                                            preferences.getString('token');
                                        await http.patch(
                                            Uri.parse(
                                                '$baseUrl/course/${course['id']}/'),
                                            headers: {
                                              'Authorization': 'token $token'
                                            },
                                            body: {
                                              'id': course['id'].toString(),
                                              'date': course['date'],
                                              'type': course['type'],
                                              'statut': 'Finis',
                                              'motard': course['motard']['user']
                                                      ['id']
                                                  .toString(),
                                              'client': course['client']['user']
                                                      ['id']
                                                  .toString(),
                                              'description':
                                                  course['description']
                                            }).then((res) {
                                          print(res.statusCode);
                                          if (res.statusCode == 200) {
                                            setState(() {
                                              status = 'Finis';
                                            });
                                          }
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: const StadiumBorder(),
                                        primary: Colors.green,
                                        padding: const EdgeInsets.only(
                                            top: 15, bottom: 15),
                                      ),
                                      child: const Text(
                                        'Fin course',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(239, 233, 255, 1),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.12,
                            ),
                            Center(
                                child: motard['photo'] != null
                                    ? Container(
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(100)),
                                          image: DecorationImage(
                                            image:
                                                NetworkImage(motard['photo']),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        height: 150,
                                        width: 150,
                                        decoration: const BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100)),
                                        ),
                                      )),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Text(
                              "Bienvenue, ${motard['nom']}",
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.14,
                            ),
                            const Text(
                              "Vous etes en attente d'une course...",
                              style: TextStyle(
                                fontSize: 24,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                print('start logout');
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                preferences.remove('token');
                                print('Logout');
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
                        )
            ],
          )),
    );
  }
}
