import 'user_mock.dart';

final List<Map<String, dynamic>> adsMocks = [
  {
    'id': '1',
    'title': 'Ad Title 1',
    'description': 'Ad Description 1',
    'price': 100.0,
    'views': 50,
    'images': ['https://image.com/image1.png', 'https://image.com/image2.png'],
    'status': 'active',
    'category': categoriesMock[0],
    'owner': usersMock[0],
    'hidePhone': false,
    'createdAt': '2025-09-07T13:13:58.279Z',
  },
  {
    'id': '2',
    'title': 'Ad Title 2',
    'description': 'Ad Description 2',
    'price': 150.0,
    'views': 30,
    'images': ['https://image.com/image1.png'],
    'status': 'pending',
    'category': categoriesMock[2],
    'owner': usersMock[1],
    'hidePhone': true,
    'createdAt': '2025-09-07T13:13:58.279Z',
  },
];

final List<Map<String, dynamic>> categoriesMock = [
  {'id': '1', 'description': 'Electronics'},
  {'id': '2', 'description': 'Vehicles'},
  {'id': '3', 'description': 'Real Estate'},
  {'id': '4', 'description': 'Jobs'},
];
