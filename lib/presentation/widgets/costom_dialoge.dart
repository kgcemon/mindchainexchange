import 'package:flutter/material.dart';
import 'package:get/get.dart';

customDialog() async {
  return Get.defaultDialog(
    contentPadding: const EdgeInsets.all(0),
    radius: 5,
    backgroundColor: Colors.white,
    title: "",
    titlePadding: const EdgeInsets.all(0),
    titleStyle: const TextStyle(fontSize: 13),
    content:  SizedBox(
      height: Get.height*0.08,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Colors.blue,
          ),
          SizedBox(
            width: 5,
          ),
          Text("Loading..."),
        ],
      ),
    ),
  );
}
