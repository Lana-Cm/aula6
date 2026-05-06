import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/usuario.dart';

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Usuario>> buscarUsuarios() async {
    final response = await http.get(Uri.parse('$_baseUrl/users'));

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar usuarios');
    }

    final lista = jsonDecode(response.body);

    return (lista as List)
        .map((e) => Usuario.fromJson(e))
        .toList();
  }
}