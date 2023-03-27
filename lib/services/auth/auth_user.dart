/*again like exception the UI code shouldn't directly working with firebase because it is so highy level so
import 'package:firebase_auth/firebase_auth.dart';

it is abdstarcted from the reset of app by giving differnet profiders and services 
forexample we shouldn't use 
final user=FirebaseAuth.instance.currentUser; in UI some we must create new absrtarct class that gives the user
*/

//
import 'package:firebase_auth/firebase_auth.dart' show User;
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

//immutable means this class or any subclasses of this class that their internals are never going to be changed upon initialization so
// they cannot have any field that changes
@immutable
class AuthUser {
  final bool isEmailVerifierd;
  const AuthUser(this.isEmailVerifierd); //constactor

//  take the emailVerified value of the firebase user and place it in this class so it is just copied the firebase user
  factory AuthUser.fromFirebase(User user) => AuthUser(user.emailVerified);
}
/* in firebase we will have differnet auth provider like google,email and password, git,phonee and other
so we need to creeate one authprovider class that encapsulate all of this provider that may we add in  the future ad create a good interface for them
*/