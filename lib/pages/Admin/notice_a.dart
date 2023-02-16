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
      appBar: AppBar(
        title: const Text("Add Notice", style: TextStyle(fontSize: 30.0)),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            // const TextField(
            //   maxLines: null,
            //   keyboardType: TextInputType.multiline,
            //   decoration: InputDecoration(
            //     focusedBorder: OutlineInputBorder(),
            //     border: OutlineInputBorder(),
            //     // contentPadding: EdgeInsets.fromLTRB(10.0, 100.0, 10.0, 100.0),
            //   ),
            // ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              margin: const EdgeInsets.only(left: 20, top: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border:
                    Border.all(style: BorderStyle.solid, color: Colors.grey),
              ),
              child: TextFormField(
                minLines: 1,
                maxLines: null,
                // controller: project_description_controller_r,
                decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "Enter notice",
                    hintStyle: TextStyle(fontSize: 18)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter notice';
                  }
                  return null;
                },
                keyboardType: TextInputType.multiline,
              ),
            ),
            const SizedBox(
              height: 20,
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
