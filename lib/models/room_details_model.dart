class RoomDetailsModel {
  final String id;
  final String house;
  final String owner;
  final String roomName;
  final String coverImage;
  final List<Surface> surface;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  RoomDetailsModel({
    required this.id,
    required this.house,
    required this.owner,
    required this.roomName,
    required this.coverImage,
    required this.surface,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory RoomDetailsModel.fromJson(Map<String, dynamic> json) {
    return RoomDetailsModel(
      id: json['_id'] ?? '',
      house: json['house'] ?? '',
      owner: json['owner'] ?? '',
      roomName: json['roomName'] ?? '',
      coverImage: json['coverImage'] ?? '',
      surface: (json['surface'] as List? ?? [])
          .map((item) => Surface.fromJson(item as Map<String, dynamic>))
          .toList(),
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      v: json['__v'] ?? 0,
    );
  }
}

class Surface {
  final String finish;
  final String surfaceName;
  final String surfaceImage;
  final String colorCode;
  final String colorDetails;
  final String purchesLocation;
  final String purchesDate;
  final String description;
  final String colorBrandName;
  final String id;

  Surface({
    required this.finish,
    required this.surfaceName,
    required this.surfaceImage,
    required this.colorCode,
    required this.colorDetails,
    required this.purchesLocation,
    required this.purchesDate,
    required this.description,
    required this.colorBrandName,
    required this.id,
  });

  factory Surface.fromJson(Map<String, dynamic> json) {
    return Surface(
      finish: json['finish'] ?? '',
      surfaceName: json['surfaceName'] ?? '',
      surfaceImage: json['surfaceImage'] ?? '',
      colorCode: json['colorCode'] ?? '',
      colorDetails: json['colorDetails'] ?? '',
      purchesLocation: json['purchesLocation'] ?? '',
      purchesDate: json['purchesDate'] ?? '',
      description: json['description'] ?? '',
      colorBrandName: json['colorBrandName'] ?? '',
      id: json['_id'] ?? '',
    );
  }
}
