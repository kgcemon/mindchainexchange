import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindchain_exchange/presentation/screens/home_screen.dart';
import 'package:mindchain_exchange/presentation/utility/app_colors.dart';

import '../controllers/nav_screen_controller.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  final NavScreenController _navController = Get.put(NavScreenController());

  List<Widget> bodyScreen = [const HomeScreen()];

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
      bottomNavigationBar: GetBuilder<NavScreenController>(builder: (controller) =>
          BottomNavigationBar(
        unselectedItemColor: Colors.white,
        selectedItemColor: AppColor.themeColor,
        backgroundColor: Colors.black,
        onTap: (index) => controller.changeScreen(index),
        currentIndex: _navController.currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shop_2_outlined), label: 'Market'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Trade'),
        ],
      ),),
      body: GetBuilder<NavScreenController>(
        builder: (controller) => bodyScreen[controller.currentIndex],
      ),
    );
  }
}
