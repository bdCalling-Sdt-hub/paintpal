class SurfaceModel {
  String surfaceName;
  String surfaceImage;
  String colorCode;
  String colorDetails;
  String purchaseLocation;
  String purchaseDate;
  String description;
  String colorBrandName;
  String id;

  SurfaceModel({
    this.surfaceName = '',
    this.surfaceImage = '',
    this.colorCode = '',
    this.colorDetails = '',
    this.purchaseLocation = '',
    this.purchaseDate = '',
    this.description = '',
    this.colorBrandName = '',
    this.id = '',
  });

  // Create a SurfaceModel object from a Map (for example, when decoding JSON)
  factory SurfaceModel.fromJson(Map<String, dynamic> json) {
    return SurfaceModel(
      surfaceName: json['surfaceName'] ?? '',
      surfaceImage: json['surfaceImage'] ?? '',
      colorCode: json['colorCode'] ?? '',
      colorDetails: json['colorDetails'] ?? '',
      purchaseLocation: json['purchesLocation'] ?? '',
      purchaseDate: json['purchesDate'] ?? '',
      description: json['description'] ?? '',
      colorBrandName: json['colorBrandName'] ?? '',
      id: json['_id'] ?? '',
    );
  }
}
