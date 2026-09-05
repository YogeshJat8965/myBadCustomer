class BusinessModel {
  final String id;
  final String userId;
  final String businessName;
  final String businessType;
  final String? businessCategory;
  final String ownerName;
  final String address;
  final String city;
  final String state;
  final String pincode;
  final String? gstNumber;
  final String? panNumber;
  final String? businessProofUrl;
  final String? additionalInfo;
  final String? rejectionReason;
  final DateTime? verifiedAt;
  final String? verifiedBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  BusinessModel({
    required this.id,
    required this.userId,
    required this.businessName,
    required this.businessType,
    this.businessCategory,
    required this.ownerName,
    required this.address,
    required this.city,
    required this.state,
    required this.pincode,
    this.gstNumber,
    this.panNumber,
    this.businessProofUrl,
    this.additionalInfo,
    this.rejectionReason,
    this.verifiedAt,
    this.verifiedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) {
    return BusinessModel(
      id: json['id'],
      userId: json['userId'],
      businessName: json['businessName'],
      businessType: json['businessType'],
      businessCategory: json['businessCategory'],
      ownerName: json['ownerName'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      pincode: json['pincode'],
      gstNumber: json['gstNumber'],
      panNumber: json['panNumber'],
      businessProofUrl: json['businessProofUrl'],
      additionalInfo: json['additionalInfo'],
      rejectionReason: json['rejectionReason'],
      verifiedAt: json['verifiedAt'] != null ? DateTime.parse(json['verifiedAt']) : null,
      verifiedBy: json['verifiedBy'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'businessName': businessName,
      'businessType': businessType,
      'businessCategory': businessCategory,
      'ownerName': ownerName,
      'address': address,
      'city': city,
      'state': state,
      'pincode': pincode,
      'gstNumber': gstNumber,
      'panNumber': panNumber,
      'businessProofUrl': businessProofUrl,
      'additionalInfo': additionalInfo,
      'rejectionReason': rejectionReason,
      'verifiedAt': verifiedAt?.toIso8601String(),
      'verifiedBy': verifiedBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
