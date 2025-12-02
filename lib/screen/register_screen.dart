import 'package:flood_detection/providers/auth_provider.dart';
import 'package:flood_detection/style/colors/flood_detection_colors.dart';
import 'package:flood_detection/widgets/auth_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      final auth = Provider.of<AuthProvider>(context, listen: false);

      try {
        await auth.register(email.text, password.text);

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Sign up successful! Please log in."),
            backgroundColor: FloodDetectionColors.statusSuccess.color,
          ),
        );
        Navigator.pop(context);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(auth.errorMessage ?? "Sign Up failed"),
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
          appBar: AppBar(
            title: Text(
              "Sign Up",
              style: TextStyle(color: colorScheme.onPrimary),
            ),
            backgroundColor: backgroundColor,
            elevation: 0,
            iconTheme: IconThemeData(color: colorScheme.onPrimary),
          ),
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: AuthForm(
                  title: "Sign Up Now",
                  emailController: email,
                  passwordController: password,
                  confirmPasswordController: confirmPassword,
                  onSubmit: _register,
                  isRegisterMode: true,
                ),
              ),
            ),
          ),
        ),
        if (authProvider.isAuthenticating)
          Positioned.fill(
            child: Container(
              color: Color.fromRGBO(0, 0, 0, 0.55),
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
