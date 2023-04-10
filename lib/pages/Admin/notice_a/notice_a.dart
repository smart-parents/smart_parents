// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/pages/Admin/notice_a/add_notice_a.dart';

class Notice extends StatefulWidget {
  const Notice({Key? key}) : super(key: key);

  @override
  State<Notice> createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  Stream<QuerySnapshot> noticesStream =
      FirebaseFirestore.instance.collection('Admin/$admin/Notices').snapshots();
  CollectionReference Notices =
      FirebaseFirestore.instance.collection('Admin/$admin/Notices');

  @override
  void initState() {
    super.initState();
  }

  deleteUser(id) async {
    Notices.doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
    FirebaseStorage.instance.ref().child('$admin/Notices/$id.jpg').delete();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: noticesStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                tooltip: "Back",
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: const Text("Notice Details",
                  style: TextStyle(fontSize: 30.0)),
            ),
            body: storedocs.isNotEmpty
                ? ListView.builder(
                    itemCount: storedocs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                scrollable: true,
                                title: Text(
                                  '${storedocs[index]['subject']}',
                                  // Enrollment[index],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${storedocs[index]['notice']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                    if (storedocs[index]['photoUrl'] !=
                                        null) ...{
                                      ImageNetwork(
                                        image:
                                            '${storedocs[index]['photoUrl']}',
                                        height: 300,
                                        width: 300,
                                        fitAndroidIos: BoxFit.contain,
                                        fitWeb: BoxFitWeb.contain,
                                        onLoading:
                                            const CircularProgressIndicator(
                                          color: kPrimaryColor,
                                        ),
                                        onError: const Icon(
                                          Icons.error,
                                          color: red,
                                        ),
                                      ),
                                    }
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Card(
                          elevation: 5,
                          shadowColor: Colors.grey[200],
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '${storedocs[index]['subject']}',
                                          // Enrollment[index],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Date : ${storedocs[index]['date']}',
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Branch : ${storedocs[index]['branch']}',
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Sem : ${storedocs[index]['sem']}',
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text("Delete"),
                                        IconButton(
                                          highlightColor: red,
                                          onPressed: () async {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      "Confirm Delete"),
                                                  content: const Text(
                                                      "Are you sure you want to delete this item?"),
                                                  actions: [
                                                    TextButton(
                                                      child:
                                                          const Text("CANCEL"),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      child:
                                                          const Text("DELETE"),
                                                      onPressed: () {
                                                        // Perform the deletion here
                                                        // ...
                                                        try {
                                                          // await delete(storedocs[index]
                                                          //         ['number'] +
                                                          //     '@sps.com');
                                                          deleteUser(
                                                              storedocs[index]
                                                                  ['id']);
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'Notice deleted.')),
                                                          );
                                                        } catch (e) {
                                                          print(e);
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                                content: Text(
                                                                    'Failed to delete Notice: $e')),
                                                          );
                                                        }
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: red,
                                          ),
                                        ),
                                        // Switch(
                                        //   value: isActive[index],
                                        //   onChanged: (bool newValue) {
                                        //     setState(() {
                                        //       isActive[index] = !isActive[index];
                                        //     });
                                        //   },
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                : Center(
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          "assets/images/No data.png",
                        ),
                        const Text(
                          "No data",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NoticeAdd(),
                  ),
                )
              },
              child: const Icon(Icons.add),
            ),
          );
        });
  }
}
