class AppConfigModel {
  final String? title;
  final String? value;
  final String? description;
  final String? created_at;

  AppConfigModel({
    required this.title,
    required this.value,
    required this.description,
    required this.created_at,
  });

   Map<String, dynamic> toJson() {
    return {
      'title': title,
      'value': value,
      'description': description,
      'created_at':created_at,
    };
  }

  factory AppConfigModel.fromJson(Map<String, dynamic> json) {
    return AppConfigModel(
      title: json['title'],
      value: json['value'],
      description: json['description'],
      created_at: json['created_at']
    );
  }
}
