import 'package:command_it/command_it.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlo_flutter_v2/src/core/errors/api_error.dart';
import 'package:xlo_flutter_v2/src/core/routers/routers.dart';
import 'package:xlo_flutter_v2/src/core/theme/app_colors.dart';
import 'package:xlo_flutter_v2/src/core/widgets/ds_icon_button.dart';
import 'package:xlo_flutter_v2/src/core/widgets/product_container.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/query/types/ad_query.dart';
import 'package:xlo_flutter_v2/src/features/dashboard/presentation/viewmodels/dashboard_viewmodel.dart';

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

  @override
  Widget build(BuildContext context) {
    final dashboardView = context.read<DashboardViewmodel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          DSIconButton(
            child: Icon(
              Icons.notifications_outlined,
              color: AppColors.primaryText,
              size: 20,
            ),
          ),
          SizedBox(width: 16),
          DSIconButton(child: Icon(Icons.shopping_bag_outlined, size: 24)),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 200,
            child: ListView.separated(
              itemCount: _products.length,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              separatorBuilder: (context, index) => SizedBox(width: 16),
              itemBuilder: (context, index) {
                final item = _products[index];

                return SizedBox(
                  height: 170,
                  width: 180,
                  child: ProductContainer(
                    image: item['image'],
                    title: item['title'],
                    price: item['price'],
                    isFavorite: item['favorite'],
                    onTap: () {
                      debugPrint('test');
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          ValueListenableBuilder<CommandResult<void, List<AdQuery>>>(
            valueListenable: dashboardView.getAllAdsCommand.results,
            builder: (context, result, _) {
              if (result.isExecuting) {
                return Center(
                  child: SizedBox(
                    width: 30.0,
                    height: 30.0,
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (result.hasError) {
                if (result.error is ApiError) {
                  return Text('Error: ${(result.error as ApiError).message}');
                }
              }
              if (result.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: result.data?.length,
                    itemBuilder: (context, index) {
                      final ad = result.data![index];
                      return ListTile(
                        title: Text(ad.title ?? 'No Title'),
                        subtitle: Text(
                          ad.category?.description ?? 'No Category',
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(Routers.test);
                        },
                      );
                    },
                  ),
                );
              }
              return Text('No data available.');
            },
          ),
        ],
      ),
    );
  }
}
