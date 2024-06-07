import 'package:flutter/material.dart';

Widget buildPasswordField(TextEditingController controller, String labelText,var key) {
  return TextFormField(
    validator: (String? value) {
      if (value?.isEmpty ?? true) {
        return 'Enter your $labelText';
      }
      return null;
    },
    controller: controller,
    obscureText: true,
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.white),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    style: const TextStyle(color: Colors.white),
  );
}