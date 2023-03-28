import 'package:dag/constants/routes.dart';
import 'package:dag/services/auth/auth_service.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('verify your email address'),
      ),
      body: Column(children: [
        const Text(
          "We've send you an email please check your email ",
        ),
        const Text(
          "If you haven't received a verification email, please press the resend button",
        ),
        TextButton(
            onPressed: () async {
              await AuthService.firebase().sendEmailVerification();
              // final user = FirebaseAuth.instance.currentUser;
              // await user?.sendEmailVerification();
              // devtools.log('Done please check your email');
              // devtools.log(user.toString());
              // //print('done');
              // //print(user);
            },
            child: const Text('resend')),
        TextButton(
          //child: Text('Register'),onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: Colors.blue,
            padding: const EdgeInsets.all(16.0),
            //textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: () async {
            await AuthService.firebase().logOut();
            //await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushNamedAndRemoveUntil(
              signuproute,
              (route) => false,
            );
          },
          child: const Text('<<BACK'),
        ),
      ]),
    );
  }
}
