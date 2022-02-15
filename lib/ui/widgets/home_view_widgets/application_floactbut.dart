import 'package:flutter/material.dart';


class ApplicationFloActBut extends StatelessWidget {
  const ApplicationFloActBut({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      child: const Icon(Icons.add, color: Colors.black38),
      backgroundColor: const Color.fromARGB(255, 255, 241, 159),
    );
  }
}