class HouseName {
  final String houseName;
  final String id;
  final bool otherHouse;

  HouseName({
    required this.houseName,
    required this.id,
    this.otherHouse = false,
  });

  factory HouseName.fromJson(Map<String, dynamic> json) {
    return HouseName(
      houseName: json['houseName'] ?? '',
      id: json['_id'] ?? '',
      otherHouse: json['otherHouse'] ?? false,
    );
  }
}
