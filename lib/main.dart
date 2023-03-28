import 'package:dag/constants/routes.dart';
import 'package:dag/pages/home.dart';
import 'package:dag/pages/login_view.dart';
import 'package:dag/pages/sign_up.dart';
import 'package:dag/pages/verify_email_view.dart';
import 'package:dag/services/auth/auth_service.dart';
import 'dart:developer' as devtools show log;
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //WidgetsFlutterBinding.ensureInitialized();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'dag',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
      routes: {
        loginroute: (context) => const LoginView(),
        signuproute: (context) => const SignUp(),
        notesroute: (context) => const NoteView(),
        homeroute: (context) => const HomePage(),
        verifyemailroute: (context) => const VerifyEmailView(),
        // or simply create as
        // '/login/':(context) => const LoginView(), like this and call '/login/' in any place But
        // this is called hard codding so it is suitable to create new file called routes and create a loginroute variable like:
        // const loginroute='/login/';
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthService.firebase().initalize(),
        /*future: Firebase.initializeApp(
          options: DefaultFirebaseOptions
              .web, //for web we use .currentdevice for android
        ),*/
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthService.firebase().currentUser;
              // final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                // if the user is verified and loged in
                //when you use final user = FirebaseAuth.instance.currentUser; you can check by if (user.emailVerified)
                if (user.isEmailVerifierd) {
                  devtools.log('Email is Verified');
                  //print('Email is verified');
                  return const NoteView();
                } else {
                  return const VerifyEmailView();
                }
              } else {
                return const LoginView();
              }
            //return const Text('Done');
            default:
              return const CircularProgressIndicator();
          }
          // print(user);
          // if(user?.emailVerified??false){
          //   print('you are verified and you can use this');}
          // else{
          //        return const  VerifyEmailView();
          //   //print('you need to verify your email first');

          // }

          // return const LoginView();
          //return const Text('Welcome to homepagege');
        });
  }
}
