import 'package:client_mobile/helpers/api.dart';
import 'package:client_mobile/models/motard.dart';
import 'package:client_mobile/pages/client/coure_en_cours.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class EnvoieDemandeCourse extends StatefulWidget {
  const EnvoieDemandeCourse({Key? key, required this.motard}) : super(key: key);

  final Motard motard;

  @override
  State<EnvoieDemandeCourse> createState() => _EnvoieDemandeCourseState();
}

const List<String> list = <String>['Personne', 'Colis'];

class _EnvoieDemandeCourseState extends State<EnvoieDemandeCourse> {
  // String valueChoose = '';
  // List listItems = ['Personne', 'Colis'];

  String dropdownValue = list.first;
  final descriptionControllor = TextEditingController();

  //
  final String baseUrl = 'http://192.168.0.101:8000/api';

  //
  Api api = Api();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Detais course',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.18,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, bottom: 5),
              child: Row(
                children: const [
                  Text(
                    'Type de course:',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: const EdgeInsets.only(left: 15, right: 23),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    dropdownColor: const Color.fromARGB(255, 237, 237, 237),
                    iconSize: 36,
                    isExpanded: true,
                    elevation: 40,
                    hint: const Text('Type de course'),
                    underline: const SizedBox(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: TextFormField(
                controller: descriptionControllor,
                minLines:
                    6, // any number you need (It works as the rows for the textarea)
                keyboardType: TextInputType.multiline,
                autocorrect: true,
                maxLines: null,
                decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width *
                  0.85, // Will take 85% of screen space
              child: ElevatedButton(
                onPressed: () async {
                  //
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  var token = preferences.getString('token');
                  var userId = preferences.getString('userId');
                  print(userId);
                  await http.post(Uri.parse('$baseUrl/course/'), body: {
                    'type': dropdownValue.trim(),
                    'statut': 'En demande',
                    'motard': widget.motard.user.id.toString(),
                    'description': descriptionControllor.text.trim(),
                    'client': userId.toString()
                  }).then((res) {
                    print(res.body);
                    if (res.statusCode == 201) {
                      //
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CourseEnCours(),
                        ),
                      );
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  primary: const Color.fromARGB(255, 31, 31, 339),
                  padding: const EdgeInsets.only(
                    top: 15,
                    bottom: 15,
                  ),
                ),
                child: const Text(
                  'Envoie demande',
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
    );
  }
}
