// // ignore_for_file: library_private_types_in_public_api

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:smart_parents/components/constants.dart';

// class UpdateDepartPage extends StatefulWidget {
//   final String id;
//   const UpdateDepartPage({Key? key, required this.id}) : super(key: key);
//   @override
//   _UpdateDepartPageState createState() => _UpdateDepartPageState();
// }

// class _UpdateDepartPageState extends State<UpdateDepartPage> {
//   final _form1Key = GlobalKey<FormState>();

//   // Updaing Student
//   CollectionReference department =
//       FirebaseFirestore.instance.collection('Admin/$admin/department');

//   Future<void> updateUser(id, name, departmentId) {
//     return department
//         .doc(id)
//         .update({
//           'name': name,
//           'departmentId': departmentId,
//         })
//         .then((value) => print("department Updated"))
//         .catchError((error) => print("Failed to update department: $error"));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Update Department"),
//         automaticallyImplyLeading: false,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           tooltip: "Back",
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         // backgroundColor: const Color.fromARGB(255, 207, 235, 255),
//       ),
//       body: Form(
//           key: _form1Key,
//           // Getting Specific Data by ID
//           child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//             future: FirebaseFirestore.instance
//                 .collection('Admin/$admin/department')
//                 .doc(widget.id)
//                 .get(),
//             builder: (_, snapshot) {
//               if (snapshot.hasError) {
//                 print('Something Went Wrong');
//               }
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//               var data = snapshot.data!.data();
//               var departmentId = data!['departmentId'];
//               var name = data['name'];
//               // var semno = data['semno'];
//               return Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
//                 child: ListView(
//                   children: [
//                     Container(
//                       margin: const EdgeInsets.symmetric(vertical: 10.0),
//                       child: TextFormField(
//                         maxLength: 2,
//                         initialValue: departmentId,
//                         autofocus: false,
//                         onChanged: (value) => departmentId = value,
//                         decoration: const InputDecoration(
//                           labelText: 'Department Id: ',
//                           labelStyle: TextStyle(fontSize: 20.0),
//                           border: OutlineInputBorder(),
//                           errorStyle: TextStyle(fontSize: 15),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please Enter department Id';
//                           } else if (value.length != 2) {
//                             return 'Please Enter Valid department Id';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     Container(
//                       margin: const EdgeInsets.symmetric(vertical: 10.0),
//                       child: TextFormField(
//                         initialValue: name,
//                         autofocus: false,
//                         onChanged: (value) => name = value,
//                         decoration: const InputDecoration(
//                           labelText: 'Name: ',
//                           labelStyle: TextStyle(fontSize: 20.0),
//                           border: OutlineInputBorder(),
//                           errorStyle: TextStyle(fontSize: 15),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please Enter department Name';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                     // Container(
//                     //   margin: EdgeInsets.symmetric(vertical: 10.0),
//                     //   child: TextFormField(
//                     //     initialValue: semno,
//                     //     autofocus: false,
//                     //     onChanged: (value) => semno = value,
//                     //     decoration: InputDecoration(
//                     //       labelText: 'Sem Number: ',
//                     //       labelStyle: TextStyle(fontSize: 20.0),
//                     //       border: OutlineInputBorder(),
//                     //       errorStyle: TextStyle(
//                     //           color: Colors.lightBlueAccent, fontSize: 15),
//                     //     ),
//                     //     validator: (value) {
//                     //       if (value == null || value.isEmpty) {
//                     //         return 'Please Enter Sem Number';
//                     //       }
//                     //       return null;
//                     //     },
//                     //   ),
//                     // ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             // Validate returns true if the form is valid, otherwise false.
//                             if (_form1Key.currentState!.validate()) {
//                               updateUser(widget.id, name, departmentId
//                                   // semno,
//                                   );
//                               Navigator.pop(context);
//                             }
//                           },
//                           child: const Text(
//                             'Update',
//                             style: TextStyle(fontSize: 18.0),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
//           )),
//     );
//   }
// }
