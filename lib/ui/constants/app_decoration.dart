import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextFiledDecorations {
  final String hintText;

  const AppTextFiledDecorations({
    required this.hintText,
  });

  InputDecoration get inputDecoration {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey),
      filled: true,
      fillColor: AppColors.backgroundFormFild,
      labelStyle: const TextStyle(color: Color.fromARGB(255, 85, 85, 85)),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
