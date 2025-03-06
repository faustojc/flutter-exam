import 'dart:convert';

import 'package:flutter_exam/model/person.dart';
import 'package:http/http.dart' as http;

class PersonRepository {
  static const String baseUrl = 'https://fakerapi.it/api/v2/persons';

  Future<List<Person>> fetchPersons({int quantity = 10}) async {
    final url = Uri.parse("$baseUrl?_quantity=$quantity&_seed=12456");

    try {
      final response = await http.get(url);
      final data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw Exception(data['message']);
      }

      return (data['data'] as List).map((e) => Person.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
