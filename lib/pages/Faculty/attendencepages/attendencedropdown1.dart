import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyDropdownMenu extends StatefulWidget {
  @override
  _MyDropdownMenuState createState() => _MyDropdownMenuState();
}

class _MyDropdownMenuState extends State<MyDropdownMenu> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Dropdown Menu')),
      body: Center(
        child: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection('department').get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            // final items = snapshot.data.docs.map((doc) => doc.data()['name']).toList();
            final items =
                snapshot.data!.docs.map((doc) => doc.get('name')).toList();
            return DropdownButton<String>(
              value: _selectedItem,
              hint: Text('Select an item'),
              items: items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedItem = value;
                });
              },
            );
          },
        ),
      ),
    );
  }
}
