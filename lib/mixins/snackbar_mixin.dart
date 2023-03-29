import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:another_flushbar/flushbar.dart';

mixin SnackbarMixin on GetxController {
  showErrorSnackbar({required String title, required String message}) {
    Flushbar(
      title: title,
      message: message,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.red,
      margin: const EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(10),
      isDismissible: true,
      //blockBackgroundInteraction: true,
    ).show(Get.context!);
  }

  showSuccessSnackbar({required String title, required String message}) {
    Flushbar(
      title: title,
      message: message,
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green,
      margin: const EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(10),
      isDismissible: true,
      //blockBackgroundInteraction: true,
    ).show(Get.context!);
  }

  showInfoSnackbar({required String title, required String message}) {
    Flushbar(
      title: title,
      message: message,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(10),
      isDismissible: true,
      //blockBackgroundInteraction: true,
    ).show(Get.context!);
  }

  showToastSnackbar({required String message}) {
    Flushbar(
      messageText: Center(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFF303030)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              message,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(10),
      isDismissible: true,
      blockBackgroundInteraction: true,
    ).show(Get.context!);
  }
}
