class RoomSize {
  final String roomSize;
  final String id;
  final String image;

  RoomSize({
    required this.roomSize,
    required this.id,
    required this.image,
  });

  factory RoomSize.fromJson(Map<String, dynamic> json) {
    return RoomSize(
      roomSize: json['roomSize'] ?? '',
      id: json['_id'] ?? '',
      image: json['coverImage'] ?? '',
    );
  }
}
