import 'package:finances/services/firebase_database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../rounded_button.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer(
    BuildContext context, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int size = 10;

    FirebaseDatabaseService firebaseDatabaseService = FirebaseDatabaseService();
    final user = FirebaseAuth.instance.currentUser!;

    var width = 20;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Image.asset(
              'assets/wallet.png',
              width: 100,
              height: 100,
              alignment: Alignment.centerLeft,
            ),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 255, 241, 159),
            ),
          ),
          ListTile(
            title: const Text('Chart'),
            leading: const Icon(Icons.pie_chart),
            onTap: () {
              Navigator.of(context).pushNamed("chart");
            },
          ),
          const Divider(
            thickness: 1,
          ),
          ListTile(
            title: const Text('Spline Chart'),
            leading: const Icon(Icons.pie_chart),
            onTap: () {
              Navigator.of(context).pushNamed("spline_chart");
            },
          ),
          const Divider(
            thickness: 1,
          ),
          Container(
            width: 50,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                firebaseDatabaseService.saveDatabaseToCSVFile(user);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35)),
              ),
              child: Text('Get CSV'),
            ),
          ),
          // RoundedButton(
          //   text: 'Get CSV',
          //   press: () async{
          //     firebaseDatabaseService.saveDatabaseToCSVFile(user);
          //   },
          //
          // ),

          const Divider(
            thickness: 1,
          ),
          RoundedButton(
            text: 'Log Out',
            press: () async {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamed("auth");
            },
          )
        ],
      ),
    );
  }
}
