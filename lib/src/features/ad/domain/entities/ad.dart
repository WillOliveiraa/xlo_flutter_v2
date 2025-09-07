import 'package:lucid_validation/lucid_validation.dart';

import '../../../auth/domain/entities/user.dart';
import 'category.dart';

enum AdStatus { pending, active, sold, deleted }

extension AdStatusExtension on AdStatus {
  Map<String, dynamic> toMap() {
    return {'value': index, 'name': name};
  }
}

class Ad extends LucidValidator<Ad> {
  final String? id;
  final String title;
  final String description;
  final num price;
  final int? views;
  final List<String> images;
  final AdStatus status;
  final Category category;
  final User owner;
  final bool? hidePhone;
  final DateTime? createdAt;

  Ad({
    this.id,
    required this.title,
    required this.description,
    required this.price,
    this.views,
    required this.images,
    this.status = AdStatus.pending,
    required this.category,
    required this.owner,
    this.hidePhone,
    this.createdAt,
  }) {
    ruleFor(
      (ad) => ad.title.trim(),
      key: 'title',
    ).notEmpty(message: 'Title is required');
    ruleFor((ad) => ad.description.trim(), key: 'description')
        .notEmpty(message: 'Description is required')
        .minLength(
          10,
          message: 'Description must be at least 10 characters long',
        );
    ruleFor(
      (ad) => ad.price,
      key: 'price',
    ).greaterThan(0, message: 'Price must be greater than 0');
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'views': views,
      'images': images,
      'status': status.toMap(),
      'category': category.toMap(),
      'owner': owner.toMap(),
      'hidePhone': hidePhone,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory Ad.fromMap(Map<String, dynamic> map) {
    return Ad(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] as String,
      description: map['description'] as String,
      price: map['price'] as num,
      views: map['views'] != null ? map['views'] as int : null,
      images: List<String>.from((map['images'] as List<String>)),
      status: AdStatus.values.firstWhere(
        (e) => e.name == (map['status'] as String),
        orElse: () => AdStatus.pending,
      ),
      category: Category.fromMap(map['category'] as Map<String, dynamic>),
      owner: User.fromMap(map['owner'] as Map<String, dynamic>),
      hidePhone: map['hidePhone'] != null ? map['hidePhone'] as bool : null,
      createdAt:
          map['createdAt'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
              : null,
    );
  }
}
