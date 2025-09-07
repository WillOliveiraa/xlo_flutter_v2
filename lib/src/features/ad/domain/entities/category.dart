import 'package:lucid_validation/lucid_validation.dart';

class Category extends LucidValidator<Category> {
  final String? id;
  final String description;

  Category({required this.description, this.id}) {
    ruleFor((category) => category.description.trim(), key: 'description')
        .notEmpty(message: 'Description is required')
        .minLength(
          3,
          message: 'Description must be at least 3 characters long',
        );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'description': description};
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] != null ? map['id'] as String : map['objectId'] as String?,
      description: map['description'] as String,
    );
  }
}
