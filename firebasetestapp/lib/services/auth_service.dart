import 'package:firebase_auth/firebase_auth.dart';

class AuthService  {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User?> get authState => _auth.authStateChanges();


  Future<String?> signIn(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    return cred.user?.uid;
  }

  Future<String?> signUp(String email, String password) async{

    final cred = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
    return cred.user?.uid;
  }

  Future<void> signOut() => _auth.signOut();

}
