import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/pages/Faculty/exam_f/addexamtime.dart';

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

  // For Deleting User
  deleteUser(id) {
    // print("User Deleted $id");
    CollectionReference exam = FirebaseFirestore.instance
        .collection('Admin/$admin/exams/${widget.docid}/exam');
    return exam
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }

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
              title: Text(widget.name, style: const TextStyle(fontSize: 30.0)),
            ),
            body: storedocs.isNotEmpty
                ? ListView.builder(
                    itemCount: storedocs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Card(
                          elevation: 5,
                          shadowColor: Colors.grey[200],
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text("Delete"),
                                    IconButton(
                                      highlightColor: red,
                                      onPressed: () async {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title:
                                                  const Text("Confirm Delete"),
                                              content: const Text(
                                                  "Are you sure you want to delete this item?"),
                                              actions: [
                                                TextButton(
                                                  child: const Text("CANCEL"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: const Text("DELETE"),
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
                                                    Navigator.of(context).pop();
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
              // backgroundColor: const Color.fromARGB(255, 207, 235, 255),
              onPressed: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => AddExamTimeTable(
                            docid: widget.docid,
                            name: widget.name,
                          )),
                ),
              },
              child: const Icon(Icons.add),
            ),
            // ),
          );
        });
  }
}
