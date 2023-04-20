// ignore_for_file: prefer_typing_uninitialized_variables, library_private_types_in_public_api, must_be_immutable, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_parents/components/constants.dart';

final _fireStore = FirebaseFirestore.instance;
// User? loggedInUser;
String? loggedName;
var id;
List<Map<String?, String>> messages = [];
// String batchyear = DateFormat('yyyy').format(DateTime.now());

class ChatStudent extends StatefulWidget {
  const ChatStudent({super.key});

  // static String id = 'chat_screen';
  @override
  _ChatStudentState createState() => _ChatStudentState();
}

class _ChatStudentState extends State<ChatStudent> {
  final messageTextController = TextEditingController();
  // final _auth = FirebaseAuth.instance;

  late String messageText = '';

  @override
  void initState() {
    super.initState();
    // getCurrentUser();
    getUserName();
  }

  // Future<void> getCurrentUser() async {
  //   try {
  //     loggedInUser = _auth.currentUser!;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  final _prefs = SharedPreferences.getInstance();
  void getUserName() async {
    final SharedPreferences prefs = await _prefs;
    id = prefs.getString('id');
    DocumentSnapshot userSnapshot =
        await _fireStore.collection('Admin/$admin/students').doc(id).get();
    loggedName = userSnapshot.get('name');
  }

  void _handleSubmitted(String text) {
    // Handle the submitted text here
    print('Submitted: $text');
    if (messageText != '') {
      Map<String?, String> messageMap = {
        id: messageText,
      };
      messages.add(messageMap);
      messageTextController.clear();
      _fireStore
          .collection('Admin/$admin/messages')
          .doc(branch)
          .get()
          .then((value) => {
                if (value.exists)
                  {
                    _fireStore
                        .collection('Admin/$admin/messages')
                        .doc(branch)
                        .update({batchyeardropdownValue: messages})
                  }
                else
                  {
                    _fireStore
                        .collection('Admin/$admin/messages')
                        .doc(branch)
                        .set({batchyeardropdownValue: messages})
                  }
              });
    } // Clear the text input field
  }

  // void _showNumberPicker(BuildContext context) {
  //   // batchyeardropdownValue = batchyear;
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         scrollable: true,
  //         title: const Text('Select a Batch'),
  //         content: dropdown(
  //           DropdownValue: batchyeardropdownValue,
  //           sTring: batchList,
  //           Hint: "Batch(Starting Year)",
  //         ),
  //         actions: [
  //           TextButton(
  //               onPressed: () {
  //                 setState(() {
  //                   // batchyear = batchyeardropdownValue;
  //                   Navigator.of(context).pop();
  //                 });
  //               },
  //               child: const Text('Ok'))
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.transparent,
        image: DecorationImage(
          image: AssetImage(background),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // backgroundColor: Colors.white,
        appBar: AppBar(
          // leading: null,
          leading: const BackButton(),
          title: const Text('️Chat with Faculty'),
          // foregroundColor: Colors.white,
          // actions: [
          //   // const BackButton(),
          //   // const Text('️Chat Students'),
          //   GestureDetector(
          //     child: TextButton.icon(
          //       label: Text(
          //         'Batch',
          //         style: GoogleFonts.rubik(
          //           color: Colors.white,
          //           fontWeight: FontWeight.bold,
          //           fontSize: 20,
          //         ),
          //       ),
          //       icon: Container(
          //         width: 60,
          //         height: 25,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(30),
          //           color: Colors.white,
          //         ),
          //         // radius: 15,
          //         // foregroundColor: Colors.white,
          //         child: Text(
          //           batchyeardropdownValue,
          //           textAlign: TextAlign.center,
          //           style: GoogleFonts.rubik(
          //             // color: Colors.white,
          //             fontWeight: FontWeight.bold,
          //             fontSize: 20,
          //           ),
          //         ),
          //       ),
          //       // const Icon(Icons.filter_list),
          //       onPressed: () {
          //         _showNumberPicker(context);
          //       },
          //     ),
          //   ),
          //   // IconButton(
          //   //     icon: const Icon(Icons.close),
          //   //     onPressed: () {
          //   //       _showNumberPicker(context);
          //   //     }),
          // ],
          // backgroundColor: const Color(0xff001c55),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // dropdown(
              //   DropdownValue: batchyeardropdownValue,
              //   sTring: batchList,
              //   Hint: "Batch(Starting Year)",
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              CustomStreamBuilder(),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageTextController,
                        onChanged: (value) {
                          messageText = value;
                        },
                        onSubmitted: _handleSubmitted,
                        decoration: kMessageTextFieldDecoration,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    RawKeyboardListener(
                      focusNode: FocusNode(),
                      onKey: (RawKeyEvent event) {
                        if (event is RawKeyUpEvent &&
                            event.logicalKey == LogicalKeyboardKey.enter) {
                          _handleSubmitted(messageTextController.text);
                        }
                      },
                      child: TextButton(
                        // style: const ButtonStyle( ),
                        // TextButton.icon(
                        onPressed: () {
                          _handleSubmitted(messageTextController.text);
                        },
                        // icon: const Icon(Icons.send),
                        // label: const Text(
                        //   'Send',
                        //   style: kSendButtonTextStyle,
                        // ),
                        child: const Text(
                          'Send',
                          style: kSendButtonTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomStreamBuilder extends StatelessWidget {
  late ScrollController _scrollController;

  CustomStreamBuilder({super.key});

  void scroll() {
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(loggedInUser);
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: _fireStore
          .collection('Admin/$admin/messages')
          .doc(branch)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
        } else if (snapshot.hasData) {
          messages = [];

          // final messagesSnapshot = snapshot.data?.docs;
          Map<String, dynamic>? data = snapshot.data?.data();
          // data![semesterdropdownValue];
          List<MessageBubble> messageBubbles = [];

          // for (var message in data) {
          //   Map<String, dynamic> chat = message.data() as Map<String, dynamic>;
          if (data != null) {
            print(batchyeardropdownValue);
            if (data[batchyeardropdownValue] != null) {
              List<dynamic> test =
                  data[batchyeardropdownValue] as List<dynamic>;
              for (var elem in test) {
                Map<String?, dynamic> tmp = elem as Map<String?, dynamic>;

                tmp.forEach((key, value) {
                  final messageText = value;
                  final messageSender = key;
                  if (messageText != null && messageSender != null) {
                    messages.add({key: value});
                    final messageBubble = MessageBubble(
                        messageText: messageText,
                        messageSender: messageSender,
                        isMineMessage: id == key ? true : false);
                    messageBubbles.add(messageBubble);
                  }
                });
              }
              scroll();
              return Expanded(
                // child: SingleChildScrollView(
                child: ListView(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 20.0,
                  ),
                  children: messageBubbles,
                ),
                // ),
              );
            } else {
              print('data[batchyeardropdownValue] == false');
            }
          } else {
            print('data==null');
          }
        } else {
          return const Center(
              child: CircularProgressIndicator(backgroundColor: kPrimaryColor));
        }
        return Container();
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {super.key,
      required this.messageText,
      required this.messageSender,
      required this.isMineMessage});

  final String messageText;
  final String messageSender;

  final bool isMineMessage;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(
          10.0,
        ),
        child: Column(
          crossAxisAlignment: isMineMessage == true
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              messageSender,
              style: const TextStyle(
                fontSize: 13.0,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 4.0,
            ),
            Container(
              constraints: const BoxConstraints(
                maxWidth: 250,
              ),
              child: Material(
                borderRadius: BorderRadius.circular(15.0),
                elevation: 5.0,
                color:
                    isMineMessage == true ? kPrimaryColor : kPrimaryLightColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10,
                  ),
                  child: Text(
                    messageText,
                    style: TextStyle(
                      fontSize: 14.0,
                      color:
                          isMineMessage == true ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
