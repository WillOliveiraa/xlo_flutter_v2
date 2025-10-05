import 'package:flutter/material.dart';
import 'package:xlo_flutter_v2/src/core/widgets/category_container.dart';
import 'package:xlo_flutter_v2/src/core/widgets/custom_banner.dart';
import 'package:xlo_flutter_v2/src/core/widgets/ds_icon_button.dart';
import 'package:xlo_flutter_v2/src/core/widgets/product_container.dart';
import 'package:xlo_flutter_v2/src/core/widgets/search_container.dart';
import 'package:xlo_flutter_v2/src/core/widgets/title_container.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<Map<String, dynamic>> _products = [
    {
      'image':
          'https://images.pexels.com/photos/2783873/pexels-photo-2783873.jpeg',
      'title': 'Relógio Cronógrafo Redondo Michael Kors',
      'price': '\$ 250.00',
      'favorite': false,
    },
    {
      'image': 'https://images.pexels.com/photos/90946/pexels-photo-90946.jpeg',
      'title': 'Câmera Preta Fujifilm Dslr',
      'price': '\$ 550.00',
      'favorite': true,
    },
    {
      'image':
          'https://images.pexels.com/photos/2536965/pexels-photo-2536965.jpeg',
      'title': 'Lote De Cosméticos Sortidos',
      'price': '\$ 65.00',
      'favorite': false,
    },
  ];
  final List<Map<String, dynamic>> _categories = [
    {'title': 'Car', 'icon': Icons.car_repair},
    {'title': 'Motocycle', 'icon': Icons.motorcycle_sharp},
    {'title': 'Bike', 'icon': Icons.pedal_bike},
    {'title': 'PC', 'icon': Icons.computer},
    {'title': 'Mobile', 'icon': Icons.phone_iphone},
  ];

  @override
  Widget build(BuildContext context) {
    // final dashboardView = context.read<DashboardViewmodel>();

    return Scaffold(
      key: widget.key,
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          DSIconButton(
            icon: Icons.notifications_outlined,
            iconSize: 20,
            onTap: () {},
          ),
          SizedBox(width: 16),
          DSIconButton(
            icon: Icons.shopping_bag_outlined,
            iconSize: 24,
            onTap: () {},
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          SearchContainer(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 16),
                  CustomBanner(
                    imageUrl:
                        'https://images.pexels.com/photos/5650023/pexels-photo-5650023.jpeg',
                    title: 'Friday Sale',
                    subtitle: 'Up to 30% Off',
                    onTap: () {},
                  ),
                  TitleContainer(title: 'Categories', onTap: () {}),
                  SizedBox(
                    height: 150,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(width: 16),
                      itemCount: _categories.length,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      itemBuilder: (context, index) {
                        final item = _categories[index];
                        return CategoryContainer(
                          icon: item['icon'],
                          title: item['title'],
                          onTap: () {
                            debugPrint(item['title']);
                          },
                        );
                      },
                    ),
                  ),
                  TitleContainer(
                    title: 'Just for you',
                    padding: EdgeInsetsDirectional.symmetric(horizontal: 16),
                    onTap: () {},
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.separated(
                      itemCount: _products.length,
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      separatorBuilder: (context, index) => SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final item = _products[index];

                        return ProductContainer(
                          image: item['image'],
                          title: item['title'],
                          price: item['price'],
                          isFavorite: item['favorite'],
                          onTap: () {
                            debugPrint(item['title']);
                          },
                          onTapFavorite: () {
                            debugPrint('Favorite: ${item['title']}');
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Container(
  //   height: 200,
  //   color: Colors.blueGrey,
  //   child: ValueListenableBuilder<
  //     CommandResult<void, List<AdQuery>>
  //   >(
  //     valueListenable: dashboardView.getAllAdsCommand.results,
  //     builder: (context, result, _) {
  //       if (result.isExecuting) {
  //         return Center(
  //           child: SizedBox(
  //             width: 30.0,
  //             height: 30.0,
  //             child: CircularProgressIndicator(),
  //           ),
  //         );
  //       }
  //       if (result.hasError) {
  //         if (result.error is ApiError) {
  //           return Text(
  //             'Error: ${(result.error as ApiError).message}',
  //           );
  //         }
  //       }
  //       if (result.hasData) {
  //         return Expanded(
  //           child: ListView.builder(
  //             itemCount: result.data?.length,
  //             itemBuilder: (context, index) {
  //               final ad = result.data![index];
  //               return ListTile(
  //                 title: Text(ad.title ?? 'No Title'),
  //                 subtitle: Text(
  //                   ad.category?.description ?? 'No Category',
  //                 ),
  //                 onTap: () {
  //                   Navigator.of(
  //                     context,
  //                   ).pushNamed(Routers.test);
  //                 },
  //               );
  //             },
  //           ),
  //         );
  //       }
  //       return Text('No data available.');
  //     },
  //   ),
  // ),
}
