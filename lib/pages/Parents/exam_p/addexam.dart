import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/components/imageshow.dart';

class AddExam extends StatefulWidget {
  const AddExam({Key? key, required this.docid, required this.name})
      : super(key: key);
  final String docid;
  final String name;
  @override
  State<AddExam> createState() => _AddExamState();
}

class _AddExamState extends State<AddExam> {
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Admin/$admin/exams/${widget.docid}/exam')
            // .doc(widget.docid)
            // .where('branch', isEqualTo: branch)
            .snapshots(),
        builder: (context, snapshot) {
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
          // var data = snapshot.data!.data();
          // var name = data!['name'];

          return
              // MaterialApp(
              // debugShowCheckedModeBanner: false,
              // theme: ThemeData(
              //   primarySwatch: Colors.lightBlue,
              // ),
              // home:
              Scaffold(
                  appBar: AppBar(
                    // backgroundColor: const Color.fromARGB(255, 207, 235, 255),
                    automaticallyImplyLeading: false,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      tooltip: "Back",
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    title: Text(widget.name,
                        style: const TextStyle(fontSize: 30.0)),
                  ),
                  body: Column(
                    children: [
                      // storedocs.isNotEmpty
                      //     ?
                      _buildPhotoWidget(),
                      Expanded(
                        child: ListView.builder(
                          itemCount: storedocs.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 5,
                              shadowColor: Colors.grey[200],
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Subject: ${storedocs[index]['subject']}',
                                          // Enrollment[index],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0),
                                        ),
                                        Text(
                                          'Date: ${storedocs[index]['date']}',
                                          // Enrollment[index],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0),
                                        ),
                                        Text(
                                          'Time: ${storedocs[index]['starttime']} to ${storedocs[index]['endtime']}',
                                          // Enrollment[index],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                      // : Center(
                      //     child: Column(
                      //       children: <Widget>[
                      //         Image.asset(
                      //           "assets/images/No data.png",
                      //         ),
                      //         const Text(
                      //           "No data",
                      //           style:
                      //               TextStyle(fontWeight: FontWeight.bold),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      ,
                    ],
                  ));
        });
  }

  @override
  void initState() {
    super.initState();
    _loadPhotoUrl();
  }

  String? docId;
  String? _imageUrl;
  void _loadPhotoUrl() async {
    // final user = FirebaseAuth.instance.currentUser;
    final doc = await FirebaseFirestore.instance
        .collection('Admin/$admin/exams')
        .doc(widget.docid)
        .get();
    setState(() {
      try {
        _imageUrl = doc.data()!['photoUrl'];
      } catch (e) {
        print('no data');
      }
    });
  }

  Widget _buildPhotoWidget() {
    if (_imageUrl != null) {
      return Container(
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => FullScreenImageScreen(
                  imageUrl: _imageUrl!,
                ),
              ),
            );
          },
          child: ImageNetwork(
            image: _imageUrl!,
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.8,
            fitAndroidIos: BoxFit.contain,
            fitWeb: BoxFitWeb.contain,
            onLoading: const CircularProgressIndicator(
              color: kPrimaryColor,
            ),
            onError: const Icon(
              Icons.error,
              color: red,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => FullScreenImageScreen(
                    imageUrl: _imageUrl!,
                  ),
                ),
              );
            },
          ),
        ),
      );
    } else {
      return const SizedBox(height: 0);
    }
  }
}
