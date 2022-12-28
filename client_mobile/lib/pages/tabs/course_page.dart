import 'package:client_mobile/helpers/api.dart';
import 'package:client_mobile/models/association.dart';
import 'package:client_mobile/models/motard.dart';
import 'package:client_mobile/models/parking.dart';
import 'package:client_mobile/models/user.dart';
import 'package:client_mobile/pages/client/details_verification.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({Key? key}) : super(key: key);

  @override
  State<CoursePage> createState() => _CoursePageState();
}

class _CoursePageState extends State<CoursePage> {
  //
  Api api = Api();

  //
  LocationPermission? permission;

  //
  final matricule = TextEditingController();

  @override
  void dispose() {
    matricule.dispose();
    super.dispose();
  }

  void showToast(BuildContext context, String msg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: const TextStyle(fontSize: 18),
        ),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
            label: 'Fermer', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    final double theHeight = MediaQuery.of(context).size.height;
    final double halfwidth = theHeight * 0.1;

    //
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
              const SizedBox(
                height: 100,
              ),
              const Text(
                'Verification',
                style: TextStyle(fontSize: 28.0),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.18,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.all(Radius.circular(25.7)),
                ),
                child: TextField(
                  controller: matricule,
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Matricule motard',
                    labelStyle: TextStyle(
                      fontSize: 14.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(100.0),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 90),
              SizedBox(
                width: MediaQuery.of(context).size.width *
                    0.85, // Will take 85% of screen space
                child: ElevatedButton(
                  onPressed: () async {
                    // permission = await Geolocator.requestPermission()
                    //     .then((value) async {
                      
                    //   return null;
                    // });
                    
                    api.getMotardByMatricule(matricule.text.trim()).then((res) {
                      //
                      if (res.data != null && res.statusCode == 200) {
                        if (res.data.length != 0) {
                          var data = res.data[0];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetalsVerification(
                                  motard: Motard(
                                      matricule: data['matricule'],
                                      parking: Parking(
                                        nom: data['parking']['nom'],
                                        adresse: data['parking']['adresse'],
                                        association: Association(
                                          user: User(
                                              id: data['parking']['association']
                                                  ['user']['id'],
                                              last_login: DateTime.parse(
                                                  data['parking']['association']
                                                      ['user']['last_login']),
                                              date_joined: DateTime.parse(
                                                  data['parking']['association']
                                                      ['user']['date_joined']),
                                              username: data['parking']
                                                      ['association']['user']
                                                  ['username'],
                                              first_name: data['parking']['association']['user']['first_name'],
                                              last_name: data['parking']['association']['user']['last_name'],
                                              email: data['parking']['association']['user']['email'],
                                              is_staff: data['parking']['association']['user']['is_staff'],
                                              is_active: data['parking']['association']['user']['is_active'],
                                              is_superuser: data['parking']['association']['user']['is_superuser'],
                                              is_association: data['parking']['association']['user']['is_association'],
                                              equipe_secours: data['parking']['association']['user']['equipe_secours'],
                                              motard: data['parking']['association']['user']['motard'],
                                              client: data['parking']['association']['user']['client']),
                                          nom: data['parking']['association']
                                              ['nom'],
                                          president: data['parking']
                                              ['association']['president'],
                                          vice_president: data['parking']
                                              ['association']['vice_president'],
                                          adresse: data['parking']
                                              ['association']['adresse'],
                                          numero_impot: data['parking']
                                              ['association']['numero_impot'],
                                          date_creation: DateTime.parse(
                                              data['parking']['association']
                                                  ['date_creation']),
                                        ),
                                      ),
                                      user: User(
                                          id: data['user']['id'],
                                          last_login: data['user']
                                                      ['last_login'] ==
                                                  null
                                              ? DateTime.parse(
                                                  data['user']['date_joined'])
                                              : DateTime.parse(
                                                  data['user']['last_login']),
                                          date_joined: DateTime.parse(
                                              data['user']['date_joined']),
                                          username: data['user']['username'],
                                          first_name: data['user']
                                              ['first_name'],
                                          last_name: data['user']['last_name'],
                                          email: data['user']['email'],
                                          is_staff: data['user']['is_staff'],
                                          is_active: data['user']['is_active'],
                                          is_superuser: data['user']
                                              ['is_superuser'],
                                          is_association: data['user']
                                              ['is_association'],
                                          equipe_secours: data['user']
                                              ['equipe_secours'],
                                          motard: data['user']['motard'],
                                          client: data['user']['client']),
                                      nom: data['nom'],
                                      post_nom: data['post_nom'],
                                      prenom: data['prenom'],
                                      photo: data['photo'],
                                      date_naissance: DateTime.parse(
                                          data['date_naissance']),
                                      genre: data['genre'],
                                      adresse: data['adresse'],
                                      telephone: data['telephone'],
                                      etat_civil: data['etat_civil'],
                                      numero_national: data['numero_national'],
                                      profession: data['profession'])),
                            ),
                          );
                        } else {
                          showToast(context, 'Motard introuvable !');
                        }
                      } else {
                        showToast(
                            context, 'Verifiez votre connexion et reessayez !');
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    primary: const Color.fromARGB(255, 31, 31, 339),
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                  ),
                  child: const Text(
                    'Verifier',
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
