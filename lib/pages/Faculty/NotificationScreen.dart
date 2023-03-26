// ignore_for_file: file_names
// import 'package:flutter/material.dart';

// class NotificationS extends StatelessWidget {
//   const NotificationS({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBar(),
//       body: listview(),
//     );
//   }

//   PreferredSizeWidget appBar() {
//     return AppBar(
//       title: const Text("Notification Screen"),
//     );
//   }

//   Widget listview() {
//     return ListView.builder(
//         itemBuilder: (BuildContext context, int index) {
//           return listViewItem(index);
//         },
//         separatorBuilder: (BuildContext context, int index) {
//           return const Divider(height: 0);
//         },
//         itemCount: 15);
//   }

//   Widget listViewItem(int index) {
//     return Container(
//         margin: const EdgeInsets.only(left: 10),
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   message(index),
//                   timeAndDate(index),
//                 ],
//               ),
//             ),
//           ],
//         ));
//   }

//   Widget prefixIcon() {
//     return Container(
//       height: 50,
//       width: 50,
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: Colors.grey.shade300,
//       ),
//       child: Icon(Icons.notifications, size: 25, color: Colors.grey.shade700),
//     );
//   }

//   Widget message(int index) {
//     double textsize = 14;
//     return Container(
//       child: RichText(
//         maxLines: 3,
//         overflow: TextOverflow.ellipsis,
//         text: TextSpan(
//             text: 'message',
//             style: TextStyle(
//                 fontSize: textsize,
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold),
//             children: [
//               const TextSpan(
//                   text: 'message description',
//                   style: TextStyle(fontWeight: FontWeight.w400)),
//             ]),
//       ),
//     );
//   }

//   Widget timeAndDate(int index) {
//     return Container(
//       margin: const EdgeInsets.only(top: 5),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Text(
//             '23-01-2023',
//             style: TextStyle(fontSize: 10),
//           ),
//           const Text(
//             '30-01-2023',
//             style: TextStyle(fontSize: 10),
//           ),
//         ],
//       ),
//     );
//   }
// }
