import 'package:flutter/material.dart';
import 'package:xlo_flutter_v2/src/core/routers/routers.dart';
import 'package:xlo_flutter_v2/src/core/theme/app_colors.dart';
import 'package:xlo_flutter_v2/src/features/ad/presentation/pages/ad_page.dart';
import 'package:xlo_flutter_v2/src/features/dashboard/presentation/pages/dashboard_page.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int currentPageIndex = 0;
  List<Widget> get _pages => [
    DashboardPage(),
    AdPage(),
    Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Container(color: Colors.red),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(Routers.login),
        tooltip: 'Login',
        child: const Icon(Icons.person),
      ),
    ),
    Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Container(color: Colors.green),
    ),
  ];

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentPageIndex],
      bottomNavigationBar: NavigationBar(
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
