import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xlo_flutter_v2/src/core/errors/api_error.dart';
import 'package:xlo_flutter_v2/src/core/theme/app_colors.dart';
import 'package:xlo_flutter_v2/src/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:xlo_flutter_v2/src/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:xlo_flutter_v2/src/features/dashboard/presentation/pages/orders_page.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  late AuthViewModel authViewModel;
  final bucket = PageStorageBucket();

  int currentPageIndex = 0;
  List<Widget> get _destinations => [
    NavigationDestination(
      selectedIcon: Icon(Icons.home),
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.list),
      selectedIcon: Icon(Icons.list_outlined),
      label: 'Orders',
    ),
    NavigationDestination(
      icon: Icon(Icons.favorite_border),
      selectedIcon: Icon(Icons.favorite),
      label: 'Favorites',
    ),
    NavigationDestination(
      icon: Icon(Icons.person_outline),
      selectedIcon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authViewModel = context.read<AuthViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      DashboardPage(key: PageStorageKey('dashboard')),
      OrdersPage(key: PageStorageKey('orders')),
      Scaffold(
        key: PageStorageKey('favorite'),
        appBar: AppBar(title: const Text('Favorites')),
        body: ListView.builder(
          itemCount: 30,
          itemBuilder: (_, index) {
            return ListTile(
              title: Text('Lorem Ipsum'),
              subtitle: Text('$index'),
              onTap: () {},
            );
          },
        ),
      ),
      Scaffold(
        key: PageStorageKey('profile'),
        appBar: AppBar(title: const Text('Profile')),
        body: ValueListenableBuilder(
          valueListenable: authViewModel.getCurrentUserCommand.results,
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
                return Text('Error: ${(result.error as ApiError).message}');
              }
            }
            if (result.hasData) {
              return Center(
                child: Column(
                  children: [
                    Text(result.data?.name ?? ''),
                    Text(result.data?.email ?? ''),
                    ValueListenableBuilder(
                      valueListenable: authViewModel.isUserLoggedIn,
                      builder: (context, isUserLoggedIn, child) {
                        return Text('isUserLoggedIn: $isUserLoggedIn');
                      },
                    ),
                  ],
                ),
              );
            }
            return Container(color: Colors.green);
          },
        ),
      ),
    ];

    final Widget currentPage = pages[currentPageIndex];
    return Scaffold(
      body: PageStorage(bucket: bucket, child: currentPage),
      bottomNavigationBar: NavigationBar(
        height: 55,
        destinations: _destinations,
        onDestinationSelected:
            (value) => setState(() => currentPageIndex = value),
        indicatorColor: AppColors.primaryLight,
        selectedIndex: currentPageIndex,
        backgroundColor: AppColors.secondaryBackground,
        animationDuration: Duration(milliseconds: 500),
        shadowColor: AppColors.shadowColor,
      ),
    );
  }
}
