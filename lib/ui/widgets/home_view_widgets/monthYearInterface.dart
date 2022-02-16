import 'package:flutter/material.dart';
import 'package:finances/viewmodels/home_model.dart';
import 'package:flutter_portal/flutter_portal.dart';

// class PickMonthAndYearOverlay extends StatefulWidget {
//
//   @override
//   _PickMonthAndYearOverlayState createState() => _PickMonthAndYearOverlayState();
// }
//
// class _PickMonthAndYearOverlayState extends State<PickMonthAndYearOverlay> {
//
//   bool _showMenu = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//
//
//
//
//     );
//   }
//
//   Widget buildGridView(HomeModel model) {
//     return GridView.count(
//       crossAxisCount: 6,
//       // Generate 100 widgets that display their index in the List.
//       children: model.months.map((month) {
//         return InkWell(
//           onTap: () {
//             model.monthClicked(month);
//           },
//           child: Center(
//             child: Text(
//               month,
//               style: TextStyle(
//                 color: model.getColor(month),
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }
// }
//
