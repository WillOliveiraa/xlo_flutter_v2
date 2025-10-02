import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:xlo_flutter_v2/src/core/routers/routers.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initSplash();
    });
  }

  Future<void> _initSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    _goToHome();
  }

  void _goToHome() {
    Navigator.pushReplacementNamed(context, Routers.initial);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Align(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Lottie.network(
                    'https://assets10.lottiefiles.com/datafiles/Hhw0wgYmETDTkxW/data.json',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
