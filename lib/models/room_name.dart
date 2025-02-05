class RoomName {
  final String roomName;
  final String roomSize;
  final String id;
  final String image;

  RoomName({
    required this.roomName,
     required this.roomSize,
    required this.id,
    required this.image,
  });

  factory RoomName.fromJson(Map<String, dynamic> json) {
    return RoomName(
      roomName: json['roomName'] ?? '',
      roomSize: json['roomSize'] ?? '',
      id: json['_id'] ?? '',
      image: json['coverImage'] ?? '',
    );
  }
}
