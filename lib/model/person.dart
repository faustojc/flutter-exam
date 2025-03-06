import 'package:flutter_exam/model/address.dart';

class Person {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final String image;
  final String phone;
  final DateTime birthday;
  final String gender;
  final String website;
  final Address address;

  String get fullName => '$firstname $lastname';

  Person({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.image,
    required this.phone,
    required this.birthday,
    required this.gender,
    required this.website,
    required this.address,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
    id: json['id'] as int,
    firstname: json['firstname'],
    lastname: json['lastname'],
    email: json['email'],
    image: json['image'],
    phone: json['phone'],
    birthday: DateTime.parse(json['birthday'] as String),
    gender: json['gender'],
    website: json['website'],
    address: Address.fromJson(json['address'] as Map<String, dynamic>),
  );
}
