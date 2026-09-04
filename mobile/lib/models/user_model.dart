class UserModel {
  final String id;
  final String? fullName;
  final String email;
  final String? phone;
  final String role;
  final String verificationStatus;
  final bool isActive;
  final DateTime? createdAt;

  UserModel({
    required this.id,
    this.fullName,
    required this.email,
    this.phone,
    required this.role,
    required this.verificationStatus,
    required this.isActive,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String?,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      role: json['role'] ?? 'USER',
      verificationStatus: json['verificationStatus'] ?? 'PENDING',
      isActive: json['isActive'] ?? true,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'role': role,
      'verificationStatus': verificationStatus,
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
