import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm/res/colors/app_colors.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Gradient gradient;

  GradientAppBar({
    required this.title,
    required this.gradient,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
        ),
        child: AppBar(
          title: Text(title, style: TextStyle(
            fontFamily: 'sourcesanspro_bold',
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: AppColors.white
          ),),
          backgroundColor: Colors.transparent,
          elevation: 0, // Remove shadow if needed
        ),
      ),
    );
  }
}
