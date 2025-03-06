class Address {
  final int id;
  final String street;
  final String streetName;
  final String buildingNumber;
  final String city;
  final String zipcode;
  final String country;
  final double latitude;
  final double longitude;

  Address({
    required this.id,
    required this.street,
    required this.streetName,
    required this.buildingNumber,
    required this.city,
    required this.zipcode,
    required this.country,
    required this.latitude,
    required this.longitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      street: json['street'],
      streetName: json['streetName'],
      buildingNumber: json['buildingNumber'],
      city: json['city'],
      zipcode: json['zipcode'],
      country: json['country'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
