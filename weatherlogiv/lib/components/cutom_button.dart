import 'package:flutter/material.dart';
import 'package:weatherlogiv/constans/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.icon,
  });
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 60,
      color: AppColors.white,
      onPressed: () {},
      icon: Icon(
        icon,
      ),
    );
  }
}
