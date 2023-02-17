import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'message.dart';

class chatpage extends StatefulWidget {
  // String email;
  // chatpage({required this.email});
  @override
  _chatpageState createState() => _chatpageState();
}

class _chatpageState extends State<chatpage> {
  // _chatpageState({required this.email});
  String email = '';
  final _prefs = SharedPreferences.getInstance();
  login() async {
    final SharedPreferences prefs = await _prefs;
    email = prefs.getString('enumber')!;
  }

  // _ChatpageState({required this.email});
  @override
  void initState() {
    login();
    super.initState();
  }

  final fs = FirebaseFirestore.instance;
  // final _auth = FirebaseAuth.instance;
  final TextEditingController message = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   appBar: AppBar(
        //     title: Text(
        //       'Chat with Faculty',
        //     ),
        //   ),
        //   body:
        SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: messages(
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
                      borderRadius: new BorderRadius.circular(10),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      // borderSide: new BorderSide(color: Colors.purple),
                      borderRadius: new BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {},
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
                icon: Icon(Icons.send_sharp),
              ),
            ],
          ),
        ],
      ),
      // ),
    );
  }
}
