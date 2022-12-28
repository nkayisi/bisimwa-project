import 'dart:convert';

import 'package:client_mobile/app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:geolocator/geolocator.dart';

class CourseEnCours extends StatefulWidget {
  const CourseEnCours({Key? key}) : super(key: key);

  @override
  State<CourseEnCours> createState() => _CourseEnCoursState();
}

class _CourseEnCoursState extends State<CourseEnCours> {
  String status = 'En courss';
  var course = {};

  //
  final String baseUrl = 'http://192.168.0.101:8000/api';

  //
  @override
  void initState() {
    super.initState();
    refresh();
  }

  //
  Future<void> refresh() async {
    //
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token');

    //
    await http.get(Uri.parse('$baseUrl/course/'),
        headers: {'Authorization': 'token $token'}).then((res) {
      if (res.statusCode == 200) {
        var resJson = json.decode(res.body).last;
        setState(() {
          status = resJson['statut'];
          course = resJson;
        });
        if (status == 'Finis') {
          //
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AppPage(),
            ),
          );
        }
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
                          height: MediaQuery.of(context).size.height * 0.40,
                        ),
                        const Text(
                          'Demande en cours... !',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ],
                    )
                  // : status == 'En cours' ?
                  : Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.20,
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
                        // Chip(
                        //   label: Text(
                        //     'Motard : ${course['motard']['nom']} ${course['motard']['post_nom']} ${course['motard']['prenom']}',
                        //     style: const TextStyle(
                        //       fontSize: 18,
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.44,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    //
                                    SharedPreferences preferences =
                                        await SharedPreferences.getInstance();
                                    var token = preferences.getString('token');
                                    // LOCATION
                                    // =============
                                    Position position =
                                        await Geolocator.getCurrentPosition(
                                            desiredAccuracy:
                                                LocationAccuracy.high);
                                    print(position);
                                    http.post(Uri.parse("$baseUrl/alerte/"),
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
                                        });
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
                                      color: Color.fromRGBO(239, 233, 255, 1),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.44,
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
                                          'statut': 'Finis',
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
                                          status = 'Finis';
                                        });
                                        refresh();
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
            ],
          )),
    );
  }
}
