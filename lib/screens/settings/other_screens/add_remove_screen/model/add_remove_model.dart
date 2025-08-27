class AddRemoveModel {
  final String userEmail;
  final String userPassword;
  final String userRole;
  final String name;
  final String? created_at;
  final bool? signed_in;

  AddRemoveModel({
    required this.userEmail,
    required this.userPassword,
    required this.userRole,
    required this.name,
    required this.created_at,
    required this.signed_in,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': userEmail,
      'password': userPassword,
      'role': userRole,
      'name': name,
      'created_at':created_at,
      'signed_in':signed_in,
    };
  }

  factory AddRemoveModel.fromJson(Map<String, dynamic> json) {
    return AddRemoveModel(
      userEmail: json['email'],
      userPassword: json['password'],
      userRole: json['role'],
      name: json['name'],
      created_at: json['created_at'],
      signed_in: json['signed_in'] as bool?,
    );
  }
}
