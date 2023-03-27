 
import 'package:dag/constants/routes.dart';
import 'package:dag/firebase_options.dart';
import 'package:dag/pages/login_view.dart';
import 'package:dag/pages/sign_up.dart';
import 'package:dag/pages/verify_email_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as devtools show log ;
//import 'package:dag/pages/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
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
        notesroute :(context) => const NoteView(),
        homeroute : (context) =>  const HomePage(),
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
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.web,//for web we use .currentdevice for android
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                // if the user is verified and loged in
                if (user.emailVerified) {
                  devtools.log('Email is Verified');
                  print('Email is verified');
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

enum MenuAction { logout }

class NoteView extends StatefulWidget {
  const NoteView({super.key});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), actions: [
        PopupMenuButton<MenuAction>(
          onSelected: (value) async {
            switch (value) {
              case MenuAction.logout:
                final shouldLogout = await showLogOutDialog(context);
                //devtools.log(shouldLogout.toString());//used as like print
                //print(shouldLogout);//to display true or false value
                if (shouldLogout) {
                  await FirebaseAuth.instance.signOut();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    loginroute,
                    (_) => false,
                  );
                }
                break;
            }
          },
          itemBuilder: (context) {
            return const [
              PopupMenuItem<MenuAction>(
                value: MenuAction.logout,
                child: Text('Log Out'),
              ),
            ];
          },
        )
      ]),
      body: const Text('welcome to main UI'),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Log out'),
          content: const Text('Do you want to Log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      }).then((value) => value ?? false);
}
