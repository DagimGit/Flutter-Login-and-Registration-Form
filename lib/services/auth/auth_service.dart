import 'package:dag/firebase_options.dart';
import 'package:dag/services/auth/auth_provider.dart';
import 'package:dag/services/auth/auth_user.dart';
import 'package:dag/services/auth/firebase_auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;
  const AuthService(this.provider);

//used to access the firebase inorder to protect initalize firebse in each file
  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) =>
      provider.createUser(
        email: email,
        password: password,
      );
  @override
  //  implement currentUser
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) =>
      provider.logIn(
        email: email,
        password: password,
      );
  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  @override
  Future<void> initalize() => provider.initalize();
}
