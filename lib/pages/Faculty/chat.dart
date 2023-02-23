import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_parents/components/constants.dart';

final _fireStore = FirebaseFirestore.instance;
User? loggedInUser;
String? loggedName;
var id;
List<Map<String?, String>> messages = [];

class ChatScreen extends StatefulWidget {
  // static String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  late String messageText = '';

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getUserName();
  }

  Future<void> getCurrentUser() async {
    try {
      loggedInUser = await _auth.currentUser!;
    } catch (e) {
      print(e);
    }
  }

  final _prefs = SharedPreferences.getInstance();
  void getUserName() async {
    final SharedPreferences prefs = await _prefs;
    id = prefs.getString('id');
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('faculty').doc(id).get();
    loggedName = userSnapshot.get('name');
  }

  @override
  Widget build(BuildContext context) {
    return
        //  Scaffold(
        //   backgroundColor: Colors.white,
        //   appBar: AppBar(
        //     leading: null,
        //     actions: [
        //       IconButton(
        //           icon: Icon(Icons.close),
        //           onPressed: () {
        //             _auth.signOut();
        //           }),
        //     ],
        //     title: Text('️Chat'),
        //     backgroundColor: Color(0xff001c55),
        //   ),
        //   body:
        SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
                    decoration: kMessageTextFieldDecoration,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (messageText != '') {
                      Map<String?, String> messageMap = {
                        id: messageText,
                      };
                      messages.add(messageMap);
                      messageTextController.clear();

                      _fireStore
                          .collection('messages')
                          .doc('chatCollection')
                          .get()
                          .then((value) => {
                                if (value.exists)
                                  {
                                    _fireStore
                                        .collection('messages')
                                        .doc('chatCollection')
                                        .update({'chat1': messages})
                                  }
                                else
                                  {
                                    _fireStore
                                        .collection('messages')
                                        .doc('chatCollection')
                                        .set({'chat1': messages})
                                  }
                              });
                    }
                  },
                  child: Text(
                    'Send',
                    style: kSendButtonTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // ),
    );
  }
}

class CustomStreamBuilder extends StatelessWidget {
  late ScrollController _scrollController;

  void scroll() {
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(loggedInUser);
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
        } else if (!snapshot.hasData) {
          return const Center(
              child: CircularProgressIndicator(
                  backgroundColor: Color.fromARGB(255, 37, 86, 116)));
        } else {
          messages = [];

          final messagesSnapshot = snapshot.data?.docs;

          List<MessageBubble> messageBubbles = [];

          for (var message in messagesSnapshot!) {
            Map<String, dynamic> chat = message.data() as Map<String, dynamic>;

            List<dynamic> test = chat['chat1'] as List<dynamic>;

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
        }
        return Container();
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble(
      {required this.messageText,
      required this.messageSender,
      required this.isMineMessage});

  final String messageText;
  final String messageSender;

  final bool isMineMessage;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(
          10.0,
        ),
        child: Column(
          crossAxisAlignment: isMineMessage == true
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              messageSender,
              style: TextStyle(
                fontSize: 13.0,
                color: Colors.black38,
              ),
            ),
            SizedBox(
              height: 4.0,
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: 250,
              ),
              child: Material(
                borderRadius: BorderRadius.circular(15.0),
                elevation: 5.0,
                color: isMineMessage == true
                    ? const Color.fromARGB(255, 37, 86, 116)
                    : const Color.fromARGB(255, 207, 235, 255),
                child: Padding(
                  padding: EdgeInsets.symmetric(
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
