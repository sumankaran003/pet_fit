import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBar(String primaryText, String secondaryText, String status) {
  Get.snackbar(
    primaryText,
    secondaryText,
    backgroundColor: status == "success"
        ? Colors.greenAccent.withOpacity(0.5)
        : Colors.redAccent.withOpacity(0.5),
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    duration: const Duration(seconds: 2),
  );
}