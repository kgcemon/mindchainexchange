import 'package:flutter/material.dart';

Widget buildSearchBar({required var controller}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), color: Colors.grey[850]),
    child: TextField(
      onChanged: (value) {
        controller.filterCrypto(value);
      },
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.white,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}