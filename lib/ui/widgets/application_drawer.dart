import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer(
      BuildContext context, {
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        ],
      ),
    );
  }
}