import 'package:dag/constants/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import '../utilites/show_error.dart';

//import 'package:dag/main.dart';
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Column(
        children: [
          TextField(
            controller: _email,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                backgroundColor: Color.fromARGB(12, 14, 16, 18)),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your Username',
            ),
          ),
          TextField(
            controller: _password,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter your Password',
            ),
            //autofillHints: ,
            obscureText: true,
          ),
          Center(
            child: TextButton(
              //child: Text('Register'),onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  final credential =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  //check whether the email is verified or not? we use this or the next
                  /*Navigator.of(context).pushNamedAndRemoveUntil(
                    homeroute,
                    (route) => false,
                  );
                  */
                  final user = FirebaseAuth.instance.currentUser;

                  if (user?.emailVerified ?? false) {
                    //user's email is verified
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      homeroute,
                      (route) => false,
                    );
                  } else {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      verifyemailroute,
                      (route) => false,
                    );
                  }

                  //Navigator.of(context).pushAndRemoveUntil(, (route) => false);
                  devtools.log(credential.toString());
                  print(credential);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    showErrorDialog(context, 'User not found');
                    //devtools.log('No user found for that email');
                    //print('No user found for that email.');
                  } else if (e.code == 'wrong-password') {
                    showErrorDialog(
                        context, 'Please enter your correct password');
                    //print('Wrong password provided for that user.');
                  } else {
                    await showErrorDialog(
                      context,
                      'Error: ${e.code}',
                    );
                  }
                } catch (e) {
                  await showErrorDialog(
                    context,
                    e.toString(),
                  );
                }
              },
              child: const Text('Login'),
            ),
          ),
          Center(
            child: Row(
              children: [
                const Text("                        You don't have account ?"),
                TextButton(
                  //child: Text('Register'),onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                    padding: const EdgeInsets.all(16.0),
                    //textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      signuproute,
                      (route) => false,
                    );
                  },
                  child: const Text('SignUp'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
