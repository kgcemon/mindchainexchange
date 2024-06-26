import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindchain_exchange/presentation/screens/home_screen/view/home_screen.dart';
import 'package:mindchain_exchange/presentation/screens/profile_screen/profile_screen.dart';
import 'package:mindchain_exchange/presentation/screens/wallet_screen/view/wallet_screen.dart';
import 'package:mindchain_exchange/presentation/utility/app_colors.dart';

import '../../wallet_screen/controller/wallet_screen_controller.dart';
import '../controller/nav_screen_controller.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  final NavScreenController _navController = Get.put(NavScreenController());

  List<Widget> bodyScreen = [const HomeScreen(),
    const WalletScreen(),
    const ProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
    Get.find<WalletScreenController>().fetchWalletData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<NavScreenController>(
        builder: (controller) => BottomNavigationBar(
          unselectedItemColor: Colors.white,
          selectedItemColor: AppColor.themeColor,
          backgroundColor: Colors.black,
          onTap: (index) => controller.changeScreen(index),
          currentIndex: _navController.currentIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.wallet), label: 'Wallet'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
      body: GetBuilder<NavScreenController>(
        builder: (controller) => bodyScreen[controller.currentIndex],
      ),
    );
  }
}
