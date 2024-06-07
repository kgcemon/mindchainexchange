import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mindchain_exchange/controller_binder.dart';
import 'package:mindchain_exchange/presentation/screens/splash_screen.dart';
import 'package:mindchain_exchange/presentation/utility/app_colors.dart';

class MindChain extends StatelessWidget {
  const MindChain({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ControllerBinder(),
      home: const SplashScreen(),
      theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.transparent,
            enabledBorder: _borderStyle(),
            border: _borderStyle(),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27),
                ),
                minimumSize: const Size(double.maxFinite, 55),
                backgroundColor: AppColor.themeColor),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              minimumSize: const Size(double.maxFinite, 55),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(27)),
                side: BorderSide(color: Colors.white),
              ),
            ),
          ),
          scaffoldBackgroundColor: const Color(0xff0F0F0F),
          colorSchemeSeed: AppColor.themeColor),
    );
  }
  _borderStyle()=>  OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: Colors.white),
  );
}
