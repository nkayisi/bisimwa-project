// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:client_mobile/pages/client/envoie_demande_course.dart';
import 'package:flutter/material.dart';

import 'package:client_mobile/models/motard.dart';

class DetalsVerification extends StatelessWidget {
  //
  const DetalsVerification({
    Key? key,
    required this.motard,
  }) : super(key: key);

  final Motard motard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Detais motard',
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
            Center(
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  image: DecorationImage(
                    image: NetworkImage(motard.photo),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 13.0, bottom: 13.0),
                child: Chip(
                  label: Text(
                    '${motard.nom} ${motard.post_nom} ${motard.prenom}',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                motard.parking.association.nom,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Matricule : ${motard.matricule}',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width *
                  0.85, // Will take 85% of screen space
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EnvoieDemandeCourse(motard: motard),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  primary: const Color.fromARGB(255, 31, 31, 339),
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                ),
                child: const Text(
                  'Demander course',
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
