class Car {
  final String chassi;
  final String name;
  final String year;

  Car({required this.chassi, required this.name, required this.year});

  Map<String, dynamic> toJson() {
    return {
      'chassi': chassi,
      'name': name,
      'year': year,
    };
  }
}
