import 'package:flutter/material.dart';

class NoTransactionsWidget extends StatelessWidget {
  const NoTransactionsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            width: 60.0),
        Image.asset(
          'assets/icons/no-money.png',
          width: 120,
          height: 120,
        ),
        Container(
        width: 30.0),
        Text(
          'No transactions\nTap + to add one.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 18),
        ),
      ],
    );
  }
}