import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_parents/pages/Student/profile_screen_s.dart';
import 'package:smart_parents/widgest/textfieldwidgetform.dart';

class EditS extends StatefulWidget {
  final String id;
  const EditS({Key? key, required this.id}) : super(key: key);
  @override
  _EditSState createState() => _EditSState();
}

class _EditSState extends State<EditS> {
  final _formKey = GlobalKey<FormState>();

  // Updaing Student
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');

  Future<void> updateUser(id, name, email, mono, year, branch, sem, batch) {
    return students
        .doc(id)
        .update(({
          'name': name,
          'email': email,
          'mono': mono,
          'year': year,
          'branch': branch,
          'sem': sem,
          'batch': batch
        }))
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 37, 86, 116),
          leading: BackButton(),
          title: Text('STUDENT DETAILS')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          // Getting Specific Data by ID
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance
                .collection('students')
                .doc(widget.id)
                .get(),
            builder: (_, snapshot) {
              if (snapshot.hasError) {
                print('Something Went Wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data!.data();
              var number = data!['number'];
              var name = data['name'];
              var email = data['email'];
              var mono = data['mono'];
              var year = data['year'];
              var branch = data['branch'];
              var sem = data['sem'];
              var batch = data['batch'];
              return Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'EDIT',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFieldWidgetForm(
                    initialValue: name,
                    label: "Name",
                    onChanged: (value) => name = value,
                    text: "$name",
                    // controller: name,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFieldWidgetForm(
                    initialValue: email,
                    onChanged: (value) => email = value,
                    label: "Email",
                    text: "$email",
                    // controller: email,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFieldWidgetForm(
                    initialValue: number,
                    onChanged: (value) => number = value,
                    readOnly: true,
                    label: "Enrollment Number",
                    text: "$number",
                    // controller: number,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFieldWidgetForm(
                    initialValue: mono,
                    onChanged: (value) => mono = value,

                    label: "Mobile Number",
                    text: "$mono",
                    // controller: mono,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: TextFieldWidgetForm(
                          initialValue: year,
                          onChanged: (value) => year = value,
                          label: "Year",
                          text: "$year",
                          // controller: year,
                        ),
                      ),
                      Flexible(
                        child: TextFieldWidgetForm(
                          initialValue: branch,
                          onChanged: (value) => branch = value,
                          label: "Branch",
                          text: "$branch",
                          // controller: branch,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: TextFieldWidgetForm(
                          initialValue: sem,
                        onChanged: (value) => sem = value,
                          label: "Semester",
                          text: "$sem",
                          // controller: sem,
                        ),
                      ),
                      Flexible(
                        child: TextFieldWidgetForm(
                          initialValue: batch,
                        onChanged: (value) => batch = value,
                          label: "Batch",
                          text: "$batch",
                          // controller: batch,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () => {
                              if (_formKey.currentState!.validate())
                                {
                                  updateUser(widget.id, name, email, mono, year,
                                      branch, sem, batch),
                                  Navigator.pop(context)
                                 
                                  
                                }
                            },
                        child: Text(
                          "Confirm",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 37, 86, 116),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0)),
                          fixedSize: Size(300, 60),
                        )),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
