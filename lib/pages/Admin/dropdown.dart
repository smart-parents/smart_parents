import 'package:flutter/material.dart';

class DropdownDemo extends StatefulWidget {
  const DropdownDemo({Key? key}) : super(key: key);
  @override
  State<DropdownDemo> createState() => _DropdownDemoState();
}

class _DropdownDemoState extends State<DropdownDemo> {
  String dropdownValue = 'Branch';
  String dropdownValue2 = 'Sem';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Notice ", style: TextStyle(fontSize: 30.0)),
      ),
      body: Center(
        child: Column(children: [
          SizedBox(
            height: 30,
          ),
          // Step 2.
          DropdownButton<String>(
            // Step 3.
            value: dropdownValue,
            // Step 4.
            items: <String>[
              'Branch',
              'It',
              'Computer',
              'Sivil',
              'Mechanical',
              'AutoMobile',
              'Electric'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(fontSize: 20),
                ),
              );
            }).toList(),
            // Step 5.
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
          ),
          Column(
            children: [
              SizedBox(
                height: 30,
              ),
              // Step 2.
              DropdownButton<String>(
                // Step 3.
                value: dropdownValue2,
                // Step 4.
                items: <String>['Sem', '1', '2', '3', '4', '5', '6', '7', '8']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }).toList(),
                // Step 5.
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              // Text(
              //   'Selected Value: $dropdownValue',
              //   style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              // )
              Form(
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
                      margin:
                          const EdgeInsets.only(left: 20, top: 20, right: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            style: BorderStyle.solid, color: Colors.grey),
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
            ],
          ),
        ]),
      ),
    );
  }
}
