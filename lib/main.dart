import 'package:flutter/material.dart' hide Router;
import 'package:finances/ui/router.dart';
import 'package:finances/locator.dart';
import 'package:flutter_portal/flutter_portal.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Portal(
        child: MaterialApp(
          title: 'Finance Tracker',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: const Color.fromARGB(255, 255, 241, 159),
          ),
          initialRoute: '/',
          onGenerateRoute: Router.generateRoute,
        )
        );
  }
}








