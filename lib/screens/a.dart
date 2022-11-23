// // ignore_for_file: file_names, prefer_const_constructors

// import 'package:flutter/material.dart';

// class SplitPage extends StatefulWidget {
//   @override
//   State<SplitPage> createState() => _SplitPageState();
// }

// class _SplitPageState extends State<SplitPage> {
//   double fullTotal = 0.0;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           for (var name in widget.namesList)
//             Builder(
//               builder: (context) {
//                 var totalAcc = 0.0;
//                 //Perform calculations here that makes changes to totalAcc and displa

//                 fullTotal += totalAcc; //Keep adding to fullTotal
//               },
//             ),
//           Text(
//             "Total: " +
//                 fullTotal
//                     .toString(), //fullTotal shows the correct value only after a hot reload
//           ),
//         ],
//       ),
//     );
//   }
// }
