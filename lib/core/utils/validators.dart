class Validators {
  Validators._();

  static String? requiredField(String? v, String message) {
    if (v == null || v.trim().isEmpty) return message;
    return null;
  }

  static String? nationalId(String? v) {
    final basic = requiredField(v, 'National ID is required');
    if (basic != null) return basic;

    final value = v!.trim();
    
    final ok = RegExp(r'^\d{10}$').hasMatch(value);
    if (!ok) return 'National ID must be 10 digits';
    return null;
  }

  static String? email(String? v) {
    final basic = requiredField(v, 'Email is required');
    if (basic != null) return basic;

    final value = v!.trim();
    final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value);
    if (!ok) return 'Enter a valid email';
    return null;
  }

  static String? password(String? v) {
    final basic = requiredField(v, 'Password is required');
    if (basic != null) return basic;

    if (v!.trim().length < 6) return 'Password must be at least 6 characters';
    return null;
  }
}
