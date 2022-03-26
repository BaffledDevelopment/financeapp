import 'package:flutter/material.dart';

class ApplicationFloActBut extends StatelessWidget {
  final Function closeMonthPicker;

  const ApplicationFloActBut(this.closeMonthPicker);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        closeMonthPicker();
        Navigator.of(context).pushNamed("new_transaction");
      },
      child: const Icon(Icons.add, color: Colors.black38),
      backgroundColor: const Color.fromARGB(255, 255, 241, 159),
    );
  }
}
