import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlo_flutter_v2/src/core/errors/api_error.dart';
import 'package:xlo_flutter_v2/src/core/routers/routers.dart';
import 'package:xlo_flutter_v2/src/features/dashboard/presentation/viewmodels/dashboard_viewmodel.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late DashboardViewmodel dashboardViewModel;

  @override
  void initState() {
    dashboardViewModel = context.read<DashboardViewmodel>();
    if (dashboardViewModel.getAllAdsCommand.value.isEmpty) {
      dashboardViewModel.getAllAdsCommand.execute();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.key,
      appBar: AppBar(title: const Text('Orders')),
      body: ValueListenableBuilder(
        valueListenable: dashboardViewModel.getAllAdsCommand.results,
        builder: (context, result, child) {
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
              return Center(
                child: Text('Error: ${(result.error as ApiError).message}'),
              );
            }
          }
          if (result.hasData) {
            return SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: result.data?.length,
                itemBuilder: (context, index) {
                  final ad = result.data![index];
                  return ListTile(
                    title: Text(ad.title ?? 'No Title'),
                    subtitle: Text(ad.category?.description ?? 'No Category'),
                    onTap: () {
                      Navigator.of(context).pushNamed(Routers.ad);
                    },
                  );
                },
              ),
            );
          }
          return Center(child: Text('No data available.'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(Routers.category),
        tooltip: 'Cadastrar um Ad',
        child: const Icon(Icons.person),
      ),
    );
  }
}
