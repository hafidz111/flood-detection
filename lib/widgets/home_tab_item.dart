import 'package:flutter/material.dart';

class HomeTabItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Color activeColor;
  final Color inactiveColor;
  final Color unselectedLabelColor;

  const HomeTabItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.activeColor,
    required this.inactiveColor,
    required this.unselectedLabelColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? activeColor : inactiveColor,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : unselectedLabelColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
