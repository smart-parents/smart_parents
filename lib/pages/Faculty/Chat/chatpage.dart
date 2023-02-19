// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'message.dart';

class Chatpage extends StatefulWidget {
  const Chatpage({super.key});

  // String email;
  // Chatpage({required this.email});
  @override
  _ChatpageState createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  String email = '';
  final _prefs = SharedPreferences.getInstance();
  login() async {
    final SharedPreferences prefs = await _prefs;
    email = prefs.getString('faculty')!;
  }

  // _ChatpageState({required this.email});
  @override
  void initState() {
    login();
    super.initState();
  }

  final fs = FirebaseFirestore.instance;
  // final _auth = FirebaseAuth.instance;
  final TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   appBar: AppBar(
        //     title: const Text(
        //       'Chat with student',
        //     ),
        //     // actions: [
        //     //   MaterialButton(
        //     //     onPressed: () {
        //     //       _auth.signOut().whenComplete(() {
        //     //         Navigator.pushReplacement(
        //     //           context,
        //     //           MaterialPageRoute(
        //     //             builder: (context) => Home(),
        //     //           ),
        //     //         );
        //     //       });
        //     //     },
        //     //     child: Text(
        //     //       "signOut",
        //     //     ),
        //     //   ),
        //     // ],
        //   ),
        //   body:
        SingleChildScrollView(
      physics: const BouncingScrollPhysics(),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Messages(
              email: email,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: message,
                  decoration: InputDecoration(
                    filled: true,
                    // fillColor: Colors.purple[100],
                    hintText: 'message',
                    enabled: true,
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      // borderSide: new BorderSide(color: Colors.purple),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      // borderSide: new BorderSide(color: Colors.purple),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  // validator: (value) {},
                  onSaved: (value) {
                    message.text = value!;
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  if (message.text.isNotEmpty) {
                    fs.collection('Messages').doc().set({
                      'message': message.text.trim(),
                      'time': DateTime.now(),
                      'email': email,
                    });

                    message.clear();
                  }
                },
                icon: const Icon(Icons.send_sharp),
              ),
            ],
          ),
        ],
      ),
      // ),
    );
  }
}
