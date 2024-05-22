import 'package:flutter/material.dart';
import 'package:flutter_mvvm/res/colors/app_colors.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;

  const RoundedButton(
      {super.key,
      required this.title,
      this.loading = false,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 40,
        width: 300,
        decoration: BoxDecoration(
            color: AppColors.buttonColor,
            borderRadius: BorderRadius.circular(12)),
        child: Center(
            child: Text(
          title,
          style: const TextStyle(color: AppColors.whiteColor),
        )),
      ),
    );
  }
}
