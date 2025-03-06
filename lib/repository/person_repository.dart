import 'dart:convert';

import 'package:flutter_exam/model/person.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class PersonRepository {
  final String baseUrl = 'https://fakerapi.it/api/v2/persons';
  final _logger = Logger(
    printer: PrettyPrinter(methodCount: 4, errorMethodCount: 8, lineLength: 120, colors: true),
  );

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
      _logger.e(e.toString(), error: e);
      rethrow;
    }
  }
}
