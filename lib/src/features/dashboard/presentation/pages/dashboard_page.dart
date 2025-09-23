import 'package:command_it/command_it.dart';
import 'package:flutter/material.dart';
import 'package:xlo_flutter_v2/src/core/errors/api_error.dart';
import 'package:xlo_flutter_v2/src/core/http/parse_server_adapter.dart';
import 'package:xlo_flutter_v2/src/features/ad/application/query/types/ad_query.dart';
import 'package:xlo_flutter_v2/src/features/ad/infra/gateway/ad_gateway_http.dart';
import 'package:xlo_flutter_v2/src/features/dashboard/presentation/viewmodels/dashboard_viewmodel.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final httpClient = ParseServerAdapter();
  late final AdGatewayHttp adGateway;
  late final DashboardViewmodel dashboardView;

  @override
  void initState() {
    super.initState();
    adGateway = AdGatewayHttp(httpClient);
    dashboardView = DashboardViewmodel(adGateway);
    // dashboardView.getAllAdsCommand.executeWithFuture();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Column(
        children: [
          Text('Welcome to the Dashboard!'),
          const SizedBox(height: 20),
          ValueListenableBuilder<CommandResult<void, List<AdQuery>>>(
            valueListenable: dashboardView.getAllAdsCommand.results,
            builder: (context, result, _) {
              if (result.isExecuting) {
                return Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
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
                          Navigator.of(context).pushNamed('/test');
                        },
                      );
                    },
                  ),
                );
              }
              return Text('No data available.');
            },
          ),
          // ListenableBuilder(
          //   listenable: dashboardView.getAllAdsCommand,
          //   builder: (context, child) {
          //     return Expanded(
          //       child: ListView.builder(
          //         itemCount: dashboardView.ads.length,
          //         itemBuilder: (context, index) {
          //           final ad = dashboardView.ads[index];
          //           return ListTile(
          //             title: Text(ad.title ?? 'No Title'),
          //             subtitle: Text(ad.category?.description ?? 'No Category'),
          //             onTap: () {
          //               Navigator.of(context).pushNamed('/test');
          //             },
          //           );
          //         },
          //       ),
          //     );
          //   },
          // ),
          // ListenableBuilder(
          //   listenable: dashboardView.getAllAdsCommand,
          //   builder: (context, child) {
          //     if (dashboardView.getAllAdsCommand.isFailure) {
          //       return Text('Error: teste');
          //     }
          //     return Expanded(
          //       child: ListView.builder(
          //         itemCount: dashboardView.ads.length,
          //         itemBuilder: (context, index) {
          //           final ad = dashboardView.ads[index];
          //           return ListTile(
          //             title: Text(ad.title ?? 'No Title'),
          //             subtitle: Text(ad.category?.description ?? 'No Category'),
          //             onTap: () {
          //               Navigator.of(context).pushNamed('/test');
          //             },
          //           );
          //         },
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
