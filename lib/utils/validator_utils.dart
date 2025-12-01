class ValidatorUtil {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email harus diisi.';
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Format email tidak valid.';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password harus diisi.';
    }
    if (value.length < 6) {
      return 'Password minimal 6 karakter.';
    }
    return null;
  }

  static String? confirmPasswordValidator(
    String? value,
    String originalPassword,
  ) {
    if (value == null || value.isEmpty) {
      return 'Konfirmasi password harus diisi.';
    }
    if (value != originalPassword) {
      return 'Password tidak cocok.';
    }
    return null;
  }
}
