import 'package:flutter_test/flutter_test.dart';

bool isValidLogin(String email, String password) {
  if (email.isEmpty || password.isEmpty) {
    return false;
  }
  return true;
}

void main() {
  group('Authentication Unit Tests', () {
    test('Empty email and password returns false', () {
      final result = isValidLogin('', '');
      expect(result, false);
    });

    test('Valid email and password returns true', () {
      final result = isValidLogin('student@test.com', '123456');
      expect(result, true);
    });
  });
}
