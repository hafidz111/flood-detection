import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return IconButton(
      icon: const Icon(Icons.logout, color: Colors.white),
      onPressed: auth.isAuthenticating ? null : () => auth.logout(),
      tooltip: "Logout",
    );
  }
}
