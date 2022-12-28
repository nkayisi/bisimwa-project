import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String api_url = 'http://192.168.0.101:8000';

class Api {
  Dio dio = Dio(BaseOptions(
    contentType: Headers.jsonContentType,
    responseType: ResponseType.json,
    followRedirects: false,
    validateStatus: (_) => true,
  ));

  Future login(username, password) async {
    try {
      Response response = await dio.post('$api_url/api/auth/login/',
          data: {'username': username, 'password': password});
      return response;
    } catch (e) {
      print(e);
    }
  }

  Future logout() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token');
      Response response = await dio.post('$api_url/api/auth/logout/',
          options: Options(headers: {'Authorization': 'token $token'}));
      preferences.remove('token');
      return response;
    } catch (e) {
      print(e);
    }
  }

  Future getCurrentUser() async {
    Options options;
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token');
      Response response = await dio.get('$api_url/api/auth/user/',
          options: Options(headers: {'Authorization': 'token $token'}));
      return response;
    } catch (e) {
      print(e);
    }
  }

  Future fetchAssociation() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token');
      Response response = await dio.get('$api_url/api/association/');
      return response;
    } on DioError catch (e) {
      print('The error is $e');
    }
  }

  Future getMotardByMatricule(matricule) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token');
      Response response =
          await dio.get('$api_url/api/motard/?matricule=$matricule');
      return response;
    } catch (e) {
      print(e);
    }
  }

  Future verificationNumeroNational(numeroNational) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token');
      Response response =
          await dio.get('$api_url/api/ceni/?numero_national=$numeroNational');
      return response;
    } catch (e) {
      print(e);
    }
  }

  Future getUtilisateurByNumeroNational(numeroNational) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token');
      Response response = await dio
          .get('$api_url/api/utilisateur/?numero_national=$numeroNational');
      return response;
    } catch (e) {
      print(e);
    }
  }

  Future InscriptionClient(formData) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var token = preferences.getString('token');
      if (token != null) {
        Response response =
            await dio.post('$api_url/api/client/', data: formData);
        return response;
      } else {
        Response response =
            await dio.post('$api_url/api/client/', data: formData);
        return response;
      }
    } catch (e) {
      print(e);
    }
  }
}
