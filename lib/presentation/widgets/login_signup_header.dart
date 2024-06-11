import 'package:flutter/material.dart';
import 'package:mindchain_exchange/presentation/widgets/app_logo.dart';

Widget buildHeader(BoxConstraints constraints, String title) {
  return Container(
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
        color: Colors.black),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
          const SizedBox(
            height: 20,
          )
        ],
      ),
    ),
  );
}
