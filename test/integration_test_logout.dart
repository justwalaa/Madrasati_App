import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Logout Integration Test', () {
    test('User session is cleared after logout', () async {
      final FirebaseAuth auth = FirebaseAuth.instance;

      await auth.signInAnonymously();
      expect(auth.currentUser, isNotNull);

      
      await auth.signOut();

      expect(auth.currentUser, isNull);
    });
  });
}
