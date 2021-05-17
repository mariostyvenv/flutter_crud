import 'dart:convert';
import 'package:crud_rapido/src/classes/Employed.dart';
import 'package:http/http.dart' as http;

class EmployedModel {
  static String url = 'http://192.168.1.3:3000';

  static Future<List<Employed>> obtener() async {
    List<Employed> employes = [];
    List employesDynamic = [];

    try {
      http.Response response = await http.get(Uri.parse("$url/listar"));
      Map<String, dynamic> mapResponse = json.decode(response.body);

      employesDynamic = mapResponse['data'];

      employesDynamic.forEach((employed) {
        employes.add(
          Employed(
            id: employed['_id'],
            names: employed['names'],
            lastnames: employed['lastnames'],
            cellphone: employed['cellphone'],
            email: employed['email'],
            password: employed['password'],
          ),
        );
      });
    } catch (e) {
      employes = [];
    }

    return employes;
  }

  static Future<bool> insert(Employed employed) async {
    bool finalResponse;

    try {
      http.Response response = await http.post(
        Uri.parse("$url/insertar"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'names': employed.names,
          'lastnames': employed.lastnames,
          'email': employed.email,
          'password': employed.password,
          'cellphone': employed.cellphone,
        }),
      );

      Map<String, dynamic> res = json.decode(response.body);

      if (res['status']) {
        finalResponse = true;
      } else {
        finalResponse = false;
      }
    } catch (e) {
      finalResponse = false;
    }

    return finalResponse;
  }

  static Future<bool> update(Employed employed) async {
    bool finalResponse;

    try {
      http.Response response = await http.put(
        Uri.parse(
          "$url/actualizar/${employed.id}",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(
          <String, String>{
            'names': employed.names,
            'lastnames': employed.lastnames,
            'email': employed.email,
            'cellphone': employed.cellphone,
            'password': employed.password
          },
        ),
      );

      Map<String, dynamic> mapResponse = json.decode(response.body);

      if (mapResponse['status']) {
        finalResponse = true;
      } else {
        finalResponse = false;
      }
    } catch (e) {
      finalResponse = false;
    }

    return finalResponse;
  }

  static Future<bool> delete(String id) async {
    bool finalResponse;

    try {
      http.Response response = await http.delete(Uri.parse("$url/borrar/$id"));
      Map<String, dynamic> mapResponse = json.decode(response.body);

      if (mapResponse['status']) {
        finalResponse = true;
      } else {
        finalResponse = false;
      }
    } catch (e) {
      finalResponse = false;
    }

    return finalResponse;
  }
}
