import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindchain_exchange/presentation/screens/sign_up_screen.dart';
import 'package:mindchain_exchange/presentation/utility/app_colors.dart';
import 'package:mindchain_exchange/presentation/widgets/instruction_text.dart';
import 'package:mindchain_exchange/presentation/widgets/login_signup_header.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FadeTransition(
                opacity: _animation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeader(constraints,"Login Account"),
                    const SizedBox(height: 32),
                    buildInstructionText("Enter Your E-mail And Password"),
                    const SizedBox(height: 16),
                    _buildTextField("Your E-mail"),
                    const SizedBox(height: 16),
                    _buildPasswordField(),
                    const SizedBox(height: 32),
                    _buildSignUpButton(Get.width),
                    const SizedBox(height: 16),
                    _buildSignInText(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }


  Widget _buildTextField(String labelText) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Enter Your Password',
        labelStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  Widget _buildSignUpButton(double screenWidth) {
    return Center(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: AppColor.themeColor,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.2,
            vertical: 16,
          ),
        ),
        child: const Text(
          'Sign In',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildSignInText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'You Are Not Registered?',
          style: TextStyle(color: Colors.white),
        ),
        InkWell(
          onTap: () => Get.to(const SignUpScreen()),
          child: const Text(
            '  Sign Up',
            style: TextStyle(color: AppColor.themeColor,),
          ),
        ),
      ],
    );
  }
}
