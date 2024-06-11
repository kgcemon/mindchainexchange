import 'package:flutter/material.dart';
import 'package:mindchain_exchange/presentation/screens/welcome_screen.dart';
import 'package:mindchain_exchange/presentation/widgets/app_logo.dart';
import '../controllers/user_auth_controller.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadingScreen();
  }

  _loadingScreen() async {
    await UserAuthController.getUserToken();
    final result = await UserAuthController.getUserToken();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        if (result.isNotEmpty) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
              (route) => false);
        } else {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const WelcomeScreen(),
              ),
              (route) => false);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            Spacer(),
            AppLogo(),
            Spacer(),
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              'Version 1.0.0',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
