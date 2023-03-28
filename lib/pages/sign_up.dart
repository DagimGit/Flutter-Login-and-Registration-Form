import 'package:dag/constants/routes.dart';
import 'package:dag/services/auth/auth_exceptions.dart';
import 'package:dag/services/auth/auth_service.dart';
import 'package:dag/utilites/show_error.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
      appBar: AppBar(
        title: const Text(
            'Welcome!! Please enter your email and password correctly to signup'),
      ),
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
                  await AuthService.firebase().createUser(
                    email: email,
                    password: password,
                  );

                  /*final credential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );*/
                  AuthService.firebase().sendEmailVerification();
                  /*final user = FirebaseAuth.instance
                      .currentUser; //used to hold the currecnt user from firebase
                 await user
                      ?.sendEmailVerification(); //used to send an email verification in time of registration
                  */
                  Navigator.of(context).pushNamed(verifyemailroute);
                  //print(credential);
                } on WeakPasswordAuthException {
                  await showErrorDialog(
                    context,
                    'The Password you proided is too weak',
                  );
                } on EmailAlreadyInUseAuthException {
                  await showErrorDialog(
                    context,
                    'The account already exit',
                  );
                } on InvalidEmailAuthException {
                  await showErrorDialog(
                    context,
                    'You enter invalid email',
                  );
                } on GenericAuthException {
                  await showErrorDialog(
                    context,
                    'unable to register please try again later',
                  );
                }
              },
              //   } on FirebaseAuthException catch (e) {
              //     if (e.code == 'weak-password') {
              //       await showErrorDialog(
              //         context,
              //         'The Password you proided is too weak',
              //       );
              //       //devtools.log('The Password you provided is too weak.');
              //       //print('The password provided is too weak.');
              //     } else if (e.code == 'email-already-in-use') {
              //       await showErrorDialog(
              //         context,
              //         'The account already exit',
              //       );
              //       //devtools.log('The account already exists for tha email.');
              //     } else if (e.code == 'invalid-email') {
              //       await showErrorDialog(
              //         context,
              //         'You enter invalid email',
              //       );
              //     } else {
              //       await showErrorDialog(
              //         context,
              //         'Error ${e.code}',
              //       );
              //     }
              //   } catch (e) {
              //     await showErrorDialog(
              //       context,
              //       e.toString(),
              //     );
              //   }
              // },
              child: const Text('SignUp'),
            ),
          ),
          Center(
            child: Row(
              children: [
                const Text("                        Aleady have account ?"),
                TextButton(
                  //child: Text('Register'),onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                    padding: const EdgeInsets.all(16.0),
                    //textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginroute, (route) => false);
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
