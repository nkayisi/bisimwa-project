import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  //
  var courses = [];

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
    await http.get(Uri.parse('$baseUrl/course/?token=$token'),
        headers: {'Authorization': 'token $token'}).then((res) {
      if (res.statusCode == 200) {
        var resJson = json.decode(res.body);
        setState(() {
          courses = resJson;
        });
      }
    });
    return;
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Historique des courses',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
          onRefresh: refresh,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: const Icon(Icons.list),
                trailing: Text(
                  courses[index]['date'],
                  style: const TextStyle(color: Colors.green, fontSize: 15),
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Text(
                        'Type : ${courses[index]['type']}',
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ),
                    Text('Motard : ${courses[index]['motard']['prenom']}'),
                  ],
                ),
              );
            },
            itemCount: courses.length,
          )),
    );
  }
}
