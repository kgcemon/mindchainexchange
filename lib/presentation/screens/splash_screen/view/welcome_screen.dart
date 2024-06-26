import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindchain_exchange/presentation/screens/sign_in_screen/view/sign_in_screen.dart';
import 'package:mindchain_exchange/presentation/screens/sign_up_screen/view/sign_up_screen.dart';
import 'package:mindchain_exchange/presentation/utility/app_colors.dart';
import 'package:mindchain_exchange/presentation/utility/assets_path.dart';
import 'package:mindchain_exchange/presentation/widgets/app_logo.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.02),
                const AppLogo(),
                SizedBox(height: screenHeight * 0.1),
                _buildWelcomeImage(screenHeight),
                SizedBox(height: screenHeight * 0.02),
                _buildWelcomeText(),
                SizedBox(height: screenHeight * 0.05),
                _buildCreateAccountButton(screenWidth),
                SizedBox(height: screenHeight * 0.02),
                _buildLoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeImage(double screenHeight) {
    return Image.asset(AssetsPath.welcomePNG,
      height: screenHeight * 0.25, // Responsive image height
    );
  }

  Widget _buildWelcomeText() {
    return const Column(
      children: [
        Text(
          "Welcome to Mindchain",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          "You can buy and sell many cryptocurrencies quickly.",
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildCreateAccountButton(double screenWidth) {
    return ElevatedButton(
      onPressed: () => Get.to(const SignUpScreen()),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: AppColor.themeColor,
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.2,
          vertical: 16,
        ),
      ),
      child: const Text(
        "Create New Account",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return TextButton(
      onPressed: () => Get.to(const SignInScreen()),
      child: const Text(
        "Login",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
