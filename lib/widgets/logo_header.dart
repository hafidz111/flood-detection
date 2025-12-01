import 'package:flutter/material.dart';

class LogoHeader extends StatelessWidget {
  final double logoHeight;

  const LogoHeader({super.key, this.logoHeight = 80});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/logo.png',
          height: logoHeight,
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}
