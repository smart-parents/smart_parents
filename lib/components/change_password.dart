// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, empty_catches

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/pages/option.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);
  // void initState() {
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
  //   // SystemUiOverlay.bottom,
  // ]);
  // }

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();

  var oldpassword = "";
  var newpassword = "";
  var confirmpassword = "";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  final currentUser = FirebaseAuth.instance.currentUser;
  // changePassword() async {
  //   try {
  //     await currentUser!.updatePassword(newPassword);
  //     FirebaseAuth.instance.signOut();
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => const LoginScreen()),
  //     );
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         // backgroundColor: Colors.lightBlueAccent,
  //         content: Text(
  //           'Your Password has been Changed. Login again !',
  //           style: TextStyle(fontSize: 18.0),
  //         ),
  //       ),
  //     );
  //   } catch (e) {}
  // }
  final _prefs = SharedPreferences.getInstance();

  Future<void> changePassword(
      String oldPassword, String newPassword, String confirmPassword) async {
    // Get the current user
    if (newPassword == confirmPassword) {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        // Handle the case where the user is not signed in
        print('User not signed in.');
        return;
      }
      // Create a credential with the user's email and old password
      final credential = EmailAuthProvider.credential(
        email: user.email ?? '',
        password: oldPassword,
      );
      try {
        // Reauthenticate the user with the old password
        await user.reauthenticateWithCredential(credential);
        // If reauthentication is successful, update the user's password
        await user.updatePassword(newPassword);
        print('Password changed successfully!');
        await FirebaseAuth.instance.signOut();
        final SharedPreferences prefs = await _prefs;
        final success = await prefs.clear();
        print(success);
        Navigator.pushAndRemoveUntil(
            context,
            PageRouteBuilder(
              pageBuilder: (context, a, b) => const Option(),
              transitionDuration: const Duration(seconds: 0),
            ),
            (route) => false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: kPrimaryLightColor,
            content: Text(
              'Password changed successfully!',
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          print('The old password is incorrect.');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: kPrimaryLightColor,
              content: Text(
                'The old password is incorrect.',
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
        } else {
          print('An error occurred: $e');
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: kPrimaryLightColor,
          content: Text(
            "Password and Confirm Password doesn't match",
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: "Back",
            onPressed: () => Navigator.of(context).pop(),
          ),
          title:
              const Text("Change Password", style: TextStyle(fontSize: 30.0)),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Old Password: ',
                      hintText: 'Enter Old Password',
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(fontSize: 15),
                    ),
                    controller: oldPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Old Password';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'New Password: ',
                      hintText: 'Enter New Password',
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(fontSize: 15),
                    ),
                    controller: newPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter New Password';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    autofocus: false,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirm New Password: ',
                      hintText: 'Enter Confirm New Password',
                      labelStyle: TextStyle(fontSize: 20.0),
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(fontSize: 15),
                    ),
                    controller: confirmNewPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Confirm Password';
                      }
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, otherwise false.
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        oldpassword = oldPasswordController.text;
                        newpassword = newPasswordController.text;
                        confirmpassword = confirmNewPasswordController.text;
                        changePassword(
                            oldpassword, newpassword, confirmpassword);
                      });
                    }
                  },
                  child: const Text(
                    'Change Password',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
