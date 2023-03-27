// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactF extends StatefulWidget {
  const ContactF({Key? key}) : super(key: key);

  @override
  _ContactFState createState() => _ContactFState();
}

class _ContactFState extends State<ContactF> {
  // final List<String> nomPrenom = [
  //   'Mrs. Binita Acharya (Hod)',
  //   'Mrs. Nikita Patel (Faculty)',
  //   'Mrs. Aesha Virani (Faculty)',
  //   'Mrs. Ankita Makode  (Faculty)',
  //   'Ms. Mayuri Devganiya (Faculty)',
  //   'Mrs. Shivani Kaniya (Faculty)'
  // ];
  // final List<String> phoneNumber = [
  //   '1234567890',
  //   '0987654321',
  //   '1112223333',
  //   '4445556666',
  //   '1478523690',
  //   '7897897890'
  // ];

  Future<void> _makePhoneCall(String phoneNumber) async {
    // Use the URL launcher to make the phone call.
    final url = 'tel:+91$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _makeEmail(String emailAddress) async {
    // Use the URL launcher to launch the email app.
    final url =
        'mailto:$emailAddress?subject=Contact between Faculty and Parents';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildPhotoWidget(String imageUrl) {
    if (imageUrl.isNotEmpty) {
      return ImageNetwork(
        image: imageUrl,
        height: 100,
        width: 100,
        fitAndroidIos: BoxFit.contain,
        fitWeb: BoxFitWeb.contain,
        onLoading: const CircularProgressIndicator(
          color: kPrimaryColor,
        ),
        onError: const Icon(
          Icons.error,
          color: red,
        ),
      );
    } else {
      return Stack(
        children: [
          Image.asset('assets/images/man.png', fit: BoxFit.cover),
          // Positioned.fill(
          //   child: Material(
          //     color: Colors.transparent,
          //     child: InkWell(
          //       onTap: _pickImage,
          //       child: Center(
          //         child: Text(
          //           _imageUrl != null
          //               ? 'Tap to update photo'
          //               : 'Tap to add photo',
          //           style: const TextStyle(
          //               color: Colors.white,
          //               fontSize: 16,
          //               fontWeight: FontWeight.bold),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(background),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Contacts'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Admin/$admin/faculty')
              .where('branch', isEqualTo: branch)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print('Something went Wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            final List storedocs = [];
            snapshot.data!.docs.map((DocumentSnapshot document) {
              Map a = document.data() as Map<String, dynamic>;
              storedocs.add(a);
              a['id'] = document.id;
            }).toList();
            return ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: storedocs.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Colors.white,
                  borderOnForeground: true,
                  elevation: 10,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildPhotoWidget(storedocs[index]['photoUrl']),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // leading: const CircleAvatar(
                                  //   backgroundImage: _buildPhotoWidget(),
                                  // ),
                                  // leading:
                                  //     _buildPhotoWidget(storedocs[index]['photoUrl']),
                                  Text('${storedocs[index]['name']}',
                                      style:
                                          const TextStyle(color: Colors.green)),
                                  Text(
                                    'Mobile No. : ${storedocs[index]['mono']}',
                                    style: const TextStyle(
                                        color: Colors.orangeAccent),
                                  ),
                                  Text(
                                    'Email : ${storedocs[index]['email']}',
                                    style: const TextStyle(
                                        color: Colors.orangeAccent),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    child: const Icon(Icons.call),
                                    onPressed: () => _makePhoneCall(
                                        storedocs[index]['mono']),
                                  ),
                                  const SizedBox(width: 8),
                                  TextButton(
                                    child: const Icon(Icons.mail),
                                    onPressed: () =>
                                        _makeEmail(storedocs[index]['email']),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            );
          },
        ),
      ),
    );
  }
}

//backup code
//
// import 'package:flutter/material.dart';

// class ContactF extends StatefulWidget {
//   const ContactF({Key? key}) : super(key: key);

//   @override
//   _ContactFState createState() => _ContactFState();
// }

// class _ContactFState extends State<ContactF> {
//   final List<String> nomPrenom = [
//     'Mrs. Binita Acharya',
//     'Ms. Nikita Patel',
//     'Mrs. Aesha Virani',
//     'Mrs. Ankita Makode',
//     'Ms. Mayuri Devganiya',
//     'Mrs. Shivani Kaniya'
//   ];
//   final List<String> phoneNumber = [
//     'Hod',
//     'Faculty',
//     'Faculty',
//     'Faculty',
//     'Faculty',
//     'Faculty'
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Contacts'),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/images/background.jpg'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: ListView.separated(
//           shrinkWrap: true,
//           padding: const EdgeInsets.all(8),
//           itemCount: nomPrenom.length,
//           itemBuilder: (BuildContext context, int index) {
//             return Card(
//               color: Colors.white,
//               borderOnForeground: true,
//               elevation: 10,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   ListTile(
//                     leading: const CircleAvatar(
//                       backgroundImage: AssetImage('assets/images/man.png'),
//                     ),
//                     title: Text(nomPrenom[index],
//                         style: const TextStyle(color: Colors.green)),
//                     subtitle: Text(
//                       phoneNumber[index],
//                       style: const TextStyle(color: Colors.orangeAccent),
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         child: const Icon(Icons.call),
//                         onPressed: () {/* ... */},
//                       ),
//                       const SizedBox(width: 8),
//                       TextButton(
//                         child: const Icon(Icons.mail),
//                         onPressed: () {/* ... */},
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           },
//           separatorBuilder: (BuildContext context, int index) =>
//               const Divider(),
//         ),
//       ),
//     );
//   }
// }
