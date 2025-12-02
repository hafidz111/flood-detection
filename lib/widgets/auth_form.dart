import 'package:flood_detection/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/validator_utils.dart';
import 'auth_input_field.dart';
import 'logo_header.dart';

class AuthForm extends StatelessWidget {
  final String title;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController? confirmPasswordController;
  final VoidCallback onSubmit;
  final bool isRegisterMode;
  final VoidCallback? onSecondaryButtonTap;

  const AuthForm({
    super.key,
    required this.title,
    required this.emailController,
    required this.passwordController,
    this.confirmPasswordController,
    required this.onSubmit,
    this.isRegisterMode = false,
    this.onSecondaryButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        const LogoHeader(),
        const SizedBox(height: 60),

        AuthInputField(
          controller: emailController,
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
          validator: ValidatorUtil.emailValidator,
        ),
        const SizedBox(height: 16),

        AuthInputField(
          controller: passwordController,
          hintText: 'Password',
          obscureText: true,
          validator: ValidatorUtil.passwordValidator,
        ),
        const SizedBox(height: 16),

        if (isRegisterMode)
          AuthInputField(
            controller: confirmPasswordController!,
            hintText: 'Konfirmasi Password',
            obscureText: true,
            validator: (value) => ValidatorUtil.confirmPasswordValidator(
              value,
              passwordController.text,
            ),
          ),

        if (isRegisterMode) const SizedBox(height: 24),

        if (!isRegisterMode) const SizedBox(height: 32),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: authProvider.isAuthenticating ? null : onSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        if (!isRegisterMode) const SizedBox(height: 24),

        if (!isRegisterMode)
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: colorScheme.surface,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Belum Punya Akun?',
                  style: TextStyle(
                    color: colorScheme.surface,
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  color: colorScheme.surface,
                ),
              ),
            ],
          ),

        if (!isRegisterMode)
          const SizedBox(height: 24),

        if (!isRegisterMode && onSecondaryButtonTap != null)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: authProvider.isAuthenticating ? null : onSecondaryButtonTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.surface,
                side: BorderSide(color: colorScheme.primary, width: 2),
                foregroundColor: colorScheme.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Daftar",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
