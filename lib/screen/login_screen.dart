import 'package:flood_detection/providers/auth_provider.dart';
import 'package:flood_detection/screen/register_screen.dart';
import 'package:flood_detection/style/colors/flood_detection_colors.dart';
import 'package:flood_detection/widgets/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final auth = Provider.of<AuthProvider>(context, listen: false);
      try {
        await auth.login(email.text, password.text);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(auth.errorMessage ?? 'Login gagal'),
            backgroundColor: FloodDetectionColors.statusFailed.color,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;
    final backgroundColor = FloodDetectionColors.backgroundDark.color;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: backgroundColor,
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: AuthForm(
                      title: "Login",
                      emailController: email,
                      passwordController: password,
                      onSubmit: _login,
                      isRegisterMode: false,
                      onSecondaryButtonTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const RegisterScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (authProvider.isAuthenticating)
          Positioned.fill(
            child: Container(
              color: const Color.fromRGBO(0, 0, 0, 0.55),
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
