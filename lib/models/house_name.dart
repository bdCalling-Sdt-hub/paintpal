class HouseName {
  final String houseName;
  final String id;

  HouseName({
    required this.houseName,
    required this.id,
  });

  factory HouseName.fromJson(Map<String, dynamic> json) {
    return HouseName(
      houseName: json['houseName'] ?? '',
      id: json['_id'] ?? '',
    );
  }
}
