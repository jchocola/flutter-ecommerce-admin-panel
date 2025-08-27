class TabModel {
  final String id;
  final String title;
  final bool isActive;

  TabModel({
    required this.id,
    required this.title,
    required this.isActive,
  });

  factory TabModel.fromJson(Map<String, dynamic> json) {
    return TabModel(
      id: json['id'] as String,
      title: json['title'], // adapt to your db field
      isActive: json['is_active'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'is_active': isActive,
      };
}
