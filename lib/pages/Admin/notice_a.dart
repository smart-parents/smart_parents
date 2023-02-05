import 'package:flutter/material.dart';

class NoticeForm extends StatefulWidget {
  const NoticeForm({
    Key? key,
  }) : super(key: key);
  // void initState() {
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  // }
  @override
  _NoticeFormState createState() => _NoticeFormState();
}

class _NoticeFormState extends State<NoticeForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const TextField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(),
                border: OutlineInputBorder(),
                // contentPadding: EdgeInsets.fromLTRB(10.0, 100.0, 10.0, 100.0),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                "Add Notice",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
