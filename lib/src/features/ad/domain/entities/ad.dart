import 'package:lucid_validation/lucid_validation.dart';
import 'package:xlo_flutter_v2/src/features/auth/domain/entities/user.dart';

import 'category.dart';

enum AdStatus { pending, active, sold, deleted }

extension AdStatusExtension on AdStatus {
  Map<String, dynamic> toMap() {
    return {'value': index, 'name': name};
  }
}

class Ad extends LucidValidator<Ad> {
  late String? _id;
  late String _title;
  late String _description;
  late num _price;
  late int? _views;
  late List<String> _images;
  late AdStatus _status;
  late Category _category;
  late User _owner;
  late bool? _hidePhone;
  late DateTime? _createdAt;

  String? get id => _id;

  void setId(String? id) => _id = id;

  String get title => _title;

  void setTitle(String title) => _title = title;

  String get description => _description;

  void setDescription(String description) => _description = description;

  num get price => _price;

  void setPrice(num price) => _price = price;

  int? get views => _views;

  void setViews(int? views) => _views = views;

  List<String> get images => _images;

  void setImages(List<String> images) => _images = images;

  AdStatus get status => _status;

  void setStatus(AdStatus status) => _status = status;

  Category get category => _category;

  void setCategory(Category category) => _category = category;

  User get owner => _owner;

  void setOwner(User owner) => _owner = owner;

  bool? get hidePhone => _hidePhone;

  void setHidePhone(bool? hidePhone) => _hidePhone = hidePhone;

  DateTime? get createdAt => _createdAt;

  void setCreatedAt(DateTime? createdAt) => _createdAt = createdAt;

  Ad({
    String? id,
    required String title,
    required String description,
    required num price,
    int? views,
    required List<String> images,
    AdStatus status = AdStatus.pending,
    required Category category,
    required User owner,
    bool? hidePhone,
    DateTime? createdAt,
  }) {
    _id = id;
    _title = title;
    _description = description;
    _price = price;
    _views = views;
    _images = images;
    _status = status;
    _category = category;
    _owner = owner;
    _hidePhone = hidePhone;
    _createdAt = createdAt;
  }

  factory Ad.empty() => Ad(
    title: '',
    description: '',
    price: 0,
    images: [],
    category: Category(description: ''),
    owner: User(id: '', name: '', email: '', phone: ''),
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'views': views,
      'images': images,
      'status': status.name,
      'category': category.toMap(),
      'user': owner.toMap(),
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
      owner: User.fromMap(map['user'] as Map<String, dynamic>),
      hidePhone: map['hidePhone'] != null ? map['hidePhone'] as bool : null,
      createdAt:
          map['createdAt'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
              : null,
    );
  }
}

class AdValidator extends LucidValidator<Ad> {
  AdValidator() {
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
    ruleFor(
      (ad) => ad.category.description.trim(),
      key: 'category',
    ).notEmpty(message: 'Category is required');
  }
}
