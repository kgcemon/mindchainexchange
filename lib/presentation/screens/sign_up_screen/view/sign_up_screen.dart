import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindchain_exchange/presentation/screens/sign_up_screen/controller/sign_up_controller.dart';
import 'package:mindchain_exchange/presentation/screens/sign_in_screen/view/sign_in_screen.dart';
import 'package:mindchain_exchange/presentation/utility/app_colors.dart';
import 'package:mindchain_exchange/presentation/widgets/costom_dialoge.dart';
import 'package:mindchain_exchange/presentation/widgets/costom_password_field.dart';
import 'package:mindchain_exchange/presentation/widgets/instruction_text.dart';
import 'package:mindchain_exchange/presentation/widgets/login_signup_header.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController emailCodesController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var signUpController = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: FadeTransition(
              opacity: _animation,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeader(constraints, 'Create Account'),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 32),
                          buildInstructionText(
                              'Enter Your Name, E-mail And Password'),
                          const SizedBox(height: 16),
                          _buildTextField(usernameController, 'User name'),
                          const SizedBox(height: 16),
                          _buildTextField(emailController, "Your E-mail"),
                          const SizedBox(height: 16),
                          _buildOtpField(emailCodesController),
                          const SizedBox(height: 16),
                          buildPasswordField(passwordController,
                              'Enter Your Password', _formKey),
                          const SizedBox(height: 32),
                          _buildSignUpButton(Get.width),
                          const SizedBox(height: 16),
                          _buildSignInText(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    usernameController.dispose();
    emailController.dispose();
    emailCodesController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return TextFormField(
      controller: controller,
      validator: (String? value) {
        if (value?.isEmpty ?? true) {
          return 'Enter your $labelText';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  Widget _buildOtpField(TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.transparent,
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: TextFormField(
              validator: (String? value) {
                if (value?.isEmpty ?? true) {
                  return 'Enter your Code';
                }
                return null;
              },
              controller: controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
                enabledBorder: _borderStyle(),
                focusedBorder: _borderStyle(),
                border: InputBorder.none,
                labelText: '  Insert Code',
                labelStyle: const TextStyle(color: Colors.white),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            flex: 3,
            child: Obx(
              () => signUpController.sendButtonText.isEmpty
                  ? InkWell(
                      onTap: () {
                        if (emailController.text.contains("@") &&
                            emailController.text.length > 5) {
                          signUpController.sendEmail(emailController.text).then(
                            (value) {
                              if (value.isNotEmpty) {
                                Get.snackbar("Result", value);
                              }
                            },
                          );
                        } else {
                          Get.snackbar(
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              "Error",
                              "Please Type Valid Email");
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          color: AppColor.themeColor,
                        ),
                        child: const Text(
                          "Send OTP",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    )
                  : Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        color: Colors.grey,
                      ),
                      child: Text(
                        signUpController.sendButtonText.value,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpButton(double screenWidth) {
    return GetBuilder<SignUpController>(
      builder: (controller) => Center(
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              customDialog();
              controller
                  .registerUser(usernameController.text, emailController.text,
                      emailCodesController.text, passwordController.text)
                  .then(
                (value) {
                  if (value == true) {
                    Get.back();
                    Get.snackbar(
                        backgroundColor: AppColor.themeColor,
                        "Error",
                        controller.errorMessage);
                  }
                },
              );
            }
          },
          child: const Text(
            'Sign Up',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already Registered?',
          style: TextStyle(color: Colors.white),
        ),
        GestureDetector(
          onTap: () => Get.offAll(const SignInScreen()),
          child: const Text(
            '  Sign In',
            style: TextStyle(color: AppColor.themeColor),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _borderStyle() =>
      const OutlineInputBorder(borderSide: BorderSide.none);
}
