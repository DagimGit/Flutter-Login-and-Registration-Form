import 'package:dag/constants/routes.dart';
import 'package:dag/enums/menu_action.dart';
import 'package:dag/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

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
                  await AuthService.firebase().logOut();
                  //  use_build_context_synchronously
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
