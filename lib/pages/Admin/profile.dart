// ignore_for_file: avoid_web_libraries_in_flutter, library_private_types_in_public_api

import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final CollectionReference<Map<String, dynamic>> _usersRef =
      FirebaseFirestore.instance.collection('users');
  Reference? _storageRef;
  String? _imageUrl;

  void _uploadImage(FileUploadInputElement fileInput) async {
    // Upload file to Firebase Storage

    final file = fileInput.files!.first;
    _storageRef = FirebaseStorage.instance
        .ref('profile_images/${DateTime.now().millisecondsSinceEpoch}');
    UploadTask uploadTask = _storageRef!.putBlob(file.slice());
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

    // Get download URL of uploaded file
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    // Update user's profile image URL in Cloud Firestore
    _usersRef.doc('USER_ID').update({'profileImageUrl': downloadUrl});

    setState(() {
      _imageUrl = downloadUrl;
    });
  }

  Future<String> _getImageUrl() async {
    // Get user's profile image URL from Cloud Firestore
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _usersRef.doc('USER_ID').get();
    String? profileImageUrl = snapshot.data()?['profileImageUrl'];

    if (profileImageUrl == null) {
      return '';
    }

    return profileImageUrl;
  }

  @override
  void initState() {
    super.initState();

    _getImageUrl().then((imageUrl) {
      setState(() {
        _imageUrl = imageUrl;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageUrl != null && _imageUrl!.isNotEmpty)
              Image.network(
                _imageUrl!,
                height: 150,
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final fileInput = FileUploadInputElement();
                fileInput.accept = 'image/*';
                fileInput.click();
                fileInput.onChange.listen((event) {
                  _uploadImage(fileInput);
                });
              },
              child: const Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}
