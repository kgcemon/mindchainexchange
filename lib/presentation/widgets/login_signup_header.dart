import 'package:flutter/material.dart';
import 'package:mindchain_exchange/presentation/widgets/app_logo.dart';

Widget buildHeader(BoxConstraints constraints,String title) {
  return Center(
    child: Column(
      children: [
        const AppLogo(),
        const SizedBox(height: 8),
         Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}