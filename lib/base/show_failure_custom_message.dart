import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xcrowme/widgets/big_text.dart';

void showFailureSnackBar(String message, {bool isError = true, String title = "Error"}) {
  Get.snackbar(
    title,
    message,
    titleText: BigText(text: title, color: Colors.white),
    messageText: Text(
      message,
      style: const TextStyle(
        color: Colors.white,
      ),
      maxLines: 2, // Adjust the number of lines as needed
      overflow: TextOverflow.ellipsis,
    ),
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    backgroundColor: Colors.redAccent,
    duration: const Duration(milliseconds: 3500),
  );
}
