class Car {
  final String chassi;
  final String name;
  final String year;

  Car({required this.chassi, required this.name, required this.year});

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      chassi: json['chassi'],
      name: json['name'],
      year: json['year'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chassi': chassi,
      'name': name,
      'year': year,
    };
  }
}
