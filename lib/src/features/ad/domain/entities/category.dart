import 'package:lucid_validation/lucid_validation.dart';

class Category extends LucidValidator<Category> {
  late String? _id;
  late String _description;

  // ignore: unnecessary_getters_setters
  String? get id => _id;

  void setId(String? value) => _id = value;

  String get description => _description;

  void setDescription(value) => _description = value;

  Category({required description, String? id}) {
    _id = id;
    _description = description;
  }

  factory Category.empty() => Category(description: '');

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'description': description};
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as String?,
      description: map['description'] as String,
    );
  }
}

class CategoryValidator extends LucidValidator<Category> {
  CategoryValidator() {
    ruleFor((category) => category.description.trim(), key: 'description')
        .notEmpty(message: 'Description is required')
        .minLength(
          3,
          message: 'Description must be at least 3 characters long',
        );
  }
}
