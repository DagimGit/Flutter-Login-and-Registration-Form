/* in firebase we will have differnet auth provider like google,email and password, git,phonee and other
so we need to creeate one authprovider class that encapsulate all of this provider that may we add in  the future ad create a good interface for them
*/
import 'package:dag/services/auth/auth_user.dart';

abstract class AuthProvider {
  AuthUser? get currentUser; // acess only create user
  Future<AuthUser> logIn({
    required String email,
    required String password,
  });
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });
  Future<void> logOut();
  Future<void> sendEmailVerification();
}
