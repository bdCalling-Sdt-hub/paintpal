class UserModel {
  final String id;
  final String fullName;
  final String phone;
  final String email;
  final String password;
  final String role;
  final String photo;
  final String address;
  final bool isOnline;
  final bool isDeleted;
  final bool isBlocked;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.password,
    required this.role,
    required this.photo,
    required this.address,
    required this.isOnline,
    required this.isDeleted,
    required this.isBlocked,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      role: json['role'] ?? 'user',
      photo: json['photo'] ?? '/uploads/profile/default-user.jpg',
      address: json['address'] ?? '',
      isOnline: json['isOnline'] == "1",
      isDeleted: json['isDelete'] == "yes",
      isBlocked: json['isBlock'] == "yes",
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }
}
