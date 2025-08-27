class UserActivityLogModel {
  final String? userID;
  final String? userRole;
  final String? userEmail;
  final String? updatedType;
  final String? value;
  final DateTime? created_at;
  final String? logID;

  UserActivityLogModel({
    required this.userID,
    required this.userRole,
    required this.userEmail,
    required this.updatedType,
    required this.value,
    required this.created_at,
    required this.logID,
  });

  Map<String, dynamic> toJson() => {
        'userID': userID,
        'userRole': userRole,
        'userEmail': userEmail,
        'updatedType': updatedType,
        'value': value,
        'created_at': created_at?.toIso8601String(),  // Fix here
        'logID': logID,
      };

  factory UserActivityLogModel.fromJson(Map<String, dynamic> json) =>
      UserActivityLogModel(
        userID: json['userID'],
        userRole: json['userRole'],
        userEmail: json['userEmail'],
        updatedType: json['updatedType'],
        value: json['value'],
        created_at: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null, // Fix here
        logID: json['logID'],
      );
}
