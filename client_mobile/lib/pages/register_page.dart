import 'package:client_mobile/helpers/api.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

const List<String> etat_civil = <String>['Célibataire', 'Marié', 'veuf'];
const List<String> genres = <String>['Femme', 'Homme'];

class _RegisterPageState extends State<RegisterPage> {
  var _obscureText = true;

  //
  void showToast(BuildContext context, String msg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          msg,
          style: const TextStyle(fontSize: 15, color: Colors.white),
        ),
        duration: const Duration(seconds: 7),
        action: SnackBarAction(
            label: 'Fermer', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  // controlors
  final usernameControllor = TextEditingController();
  final passwordControllor = TextEditingController();
  final confirmControllor = TextEditingController();
  final nomControllor = TextEditingController();
  final postNomControllor = TextEditingController();
  final prenomControllor = TextEditingController();
  final adresseControllor = TextEditingController();
  final telephoneControllor = TextEditingController();
  final professionControllor = TextEditingController();
  final numeroNationalControllor = TextEditingController();
  final photoControllor = TextEditingController();

  //
  String birthday = '';
  String dropdownValueGenre = genres.first;
  String dropdownValueEtatCivil = etat_civil.first;

  //
  Api api = Api();

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Sign-Up',
          style: TextStyle(fontSize: 20.0, color: Colors.black),
        ),
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
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.all(Radius.circular(25.7))),
                child: TextField(
                  controller: usernameControllor,
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
              const SizedBox(height: 30.0),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.all(Radius.circular(25.7))),
                child: TextField(
                  controller: passwordControllor,
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
              const SizedBox(height: 30.0),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.all(Radius.circular(25.7))),
                child: TextField(
                  controller: confirmControllor,
                  obscureText: _obscureText,
                  style: const TextStyle(
                    fontSize: 13.0,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Confirm',
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
              const SizedBox(height: 30.0),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.all(Radius.circular(25.7))),
                child: TextField(
                  controller: nomControllor,
                  style: const TextStyle(
                    fontSize: 13.0,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Nom',
                    labelStyle: TextStyle(
                      fontSize: 13.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.all(Radius.circular(25.7))),
                child: TextField(
                  controller: postNomControllor,
                  style: const TextStyle(
                    fontSize: 13.0,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Post-Nom',
                    labelStyle: TextStyle(
                      fontSize: 13.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.all(Radius.circular(25.7))),
                child: TextField(
                  controller: prenomControllor,
                  style: const TextStyle(
                    fontSize: 13.0,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Prenom',
                    labelStyle: TextStyle(
                      fontSize: 13.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.all(Radius.circular(25.7))),
                child: DateTimeFormField(
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.black45),
                    errorStyle: TextStyle(color: Colors.redAccent),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    ),
                    suffixIcon: Icon(Icons.event_note),
                    labelText: 'Date de naissance',
                  ),
                  mode: DateTimeFieldPickerMode.date,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (e) =>
                      (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                  onDateSelected: (DateTime value) {
                    birthday = value.toString();
                  },
                ),
              ),
              const SizedBox(height: 30.0),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 0, right: 0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.only(left: 15, right: 23),
                    child: DropdownButton<String>(
                      value: dropdownValueGenre,
                      icon: const Icon(Icons.arrow_drop_down),
                      dropdownColor: const Color.fromARGB(255, 237, 237, 237),
                      iconSize: 36,
                      isExpanded: true,
                      elevation: 40,
                      hint: const Text('Genre'),
                      underline: const SizedBox(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValueGenre = value!;
                        });
                      },
                      items:
                          genres.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 0, right: 0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.only(left: 15, right: 23),
                    child: DropdownButton<String>(
                      value: dropdownValueEtatCivil,
                      icon: const Icon(Icons.arrow_drop_down),
                      dropdownColor: const Color.fromARGB(255, 237, 237, 237),
                      iconSize: 36,
                      isExpanded: true,
                      elevation: 40,
                      hint: const Text('Etat-civil'),
                      underline: const SizedBox(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValueEtatCivil = value!;
                        });
                      },
                      items: etat_civil
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.all(Radius.circular(25.7))),
                child: TextField(
                  controller: adresseControllor,
                  style: const TextStyle(
                    fontSize: 13.0,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Adresse',
                    labelStyle: TextStyle(
                      fontSize: 13.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.all(Radius.circular(25.7))),
                child: TextField(
                  controller: telephoneControllor,
                  style: const TextStyle(
                    fontSize: 13.0,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Téléphone',
                    labelStyle: TextStyle(
                      fontSize: 13.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.all(Radius.circular(25.7))),
                child: TextField(
                  controller: professionControllor,
                  style: const TextStyle(
                    fontSize: 13.0,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Profession',
                    labelStyle: TextStyle(
                      fontSize: 13.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Numéro national
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.all(Radius.circular(25.7))),
                child: TextField(
                  controller: numeroNationalControllor,
                  style: const TextStyle(
                    fontSize: 13.0,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Numéro National',
                    labelStyle: TextStyle(
                      fontSize: 13.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              //Button Enregistrer
              SizedBox(
                width: MediaQuery.of(context).size.width *
                    0.85, // Will take 85% of screen space
                child: ElevatedButton(
                  onPressed: () {
                    if (passwordControllor.text.trim() ==
                        confirmControllor.text.trim()) {
                      api
                          .verificationNumeroNational(
                              numeroNationalControllor.text.trim())
                          .then((res) {
                        var data = res.toString();
                        //
                        if (data.contains('id')) {
                          api
                              .getUtilisateurByNumeroNational(
                                  numeroNationalControllor.text.trim())
                              .then((res) {
                            var data = res.toString();
                            print(data);

                            if (data.contains('id')) {
                              showToast(context,
                                  "Ce Numéro national a déjà un compte !");
                            } else {
                              print('Right password !');
                              var formData = {
                                'username': usernameControllor.text.trim(),
                                'password': passwordControllor.text.trim(),
                                'nom': nomControllor.text.trim(),
                                'post_nom': postNomControllor.text.trim(),
                                'prenom': prenomControllor.text.trim(),
                                'genre': dropdownValueGenre,
                                'etat_civil': dropdownValueEtatCivil,
                                'date_naissance': birthday,
                                'adresse': adresseControllor.text.trim(),
                                'telephone': telephoneControllor.text.trim(),
                                'profession': professionControllor.text.trim(),
                                'numero_national':
                                    numeroNationalControllor.text.trim(),
                              };
                              api.InscriptionClient(formData).then((res) {
                                if (res.statusCode == 200 ||
                                    res.statusCode == 201) {
                                  Navigator.of(context).pop();
                                }
                              });
                            }
                          });
                        } else {
                          showToast(context,
                              "Numéro national introuvable dans la base des données de la CENI !");
                        }
                      });
                    } else {
                      showToast(context, "Password don't match !");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    primary: const Color.fromARGB(255, 31, 31, 339),
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                  ),
                  child: const Text(
                    'Register',
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
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Allready have a account? ',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Sign-In",
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
