import 'package:xlo_flutter_v2/src/features/ad/domain/entities/ad.dart';
import 'package:xlo_flutter_v2/src/features/ad/domain/entities/category.dart';
import 'package:xlo_flutter_v2/src/features/auth/domain/entities/user.dart';

class AdQuery {
  final String? id;
  final String? title;
  final String? description;
  final num? price;
  final int? views;
  final List<String>? images;
  final AdStatus? status;
  final Category? category;
  final User? owner;
  final bool? hidePhone;
  final DateTime? createdAt;

  AdQuery({
    this.id,
    this.title,
    this.description,
    this.price,
    this.views,
    this.images,
    this.status,
    this.category,
    this.owner,
    this.hidePhone,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'views': views,
      'images': images,
      'status': status?.toMap(),
      'category': category?.toMap(),
      'owner': owner?.toMap(),
      'hidePhone': hidePhone,
      'createdAt': createdAt,
    };
  }

  factory AdQuery.fromMap(Map<String, dynamic> map) {
    return AdQuery(
      id: map['id'] as String?,
      title: map['title'] as String?,
      description: map['description'] as String?,
      price: map['price'] as num?,
      views: map['views'] as int?,
      images: List<String>.from((map['images'] ?? [] as List<String>)),
      status:
          map['status'] != null
              ? AdStatus.values.firstWhere(
                (e) => e.name == (map['status'] as String),
                orElse: () => AdStatus.pending,
              )
              : null,
      category: Category.fromMap(map['category'] as Map<String, dynamic>),
      owner:
          map['owner'] != null
              ? User.fromMap(map['owner'] as Map<String, dynamic>)
              : null,
      hidePhone: map['hidePhone'] as bool?,
      createdAt:
          map['createdAt'] != null ? DateTime.tryParse(map['createdAt']) : null,
    );
  }
}
