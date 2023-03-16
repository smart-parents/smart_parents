// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/pages/Parents/user_main_p.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);
  // void initState() {
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  // }
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  var number = "";
  var password = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // final storage = new FlutterSecureStorage();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  check() async {
    final snapShot = await FirebaseFirestore.instance
        .collection('Users')
        .where('id', isEqualTo: number)
        .where('role', isEqualTo: 'parents')
        .where('status', isEqualTo: true)
        .get();
    if (snapShot.docs.isNotEmpty) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: "$number@spp.com", password: password);
        print(userCredential.user?.uid);
        for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapShot.docs) {
          admin = doc.get('admin');
          // do something with the fieldValue
        }
        // await storage.write(key: "uid", value: userCredential.user?.uid);
        final SharedPreferences prefs = await _prefs;
        await prefs.setString('uid', userCredential.user?.uid as String);
        await prefs.setString('role', 'parents');
        await prefs.setString('number', "$number@spp.com");
        await prefs.setString('pass', password);
        await prefs.setString('id', number);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ParentsScreen(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        print(e);
        if (e.code == 'user-not-found') {
          print("No User Found for that Enrollment number");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              // backgroundColor: Colors.lightBlueAccent,
              content: Text(
                "No User Found for that Enrollment number",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
        } else if (e.code == 'wrong-password') {
          print("Wrong Password Provided by User");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              // backgroundColor: Colors.lightBlueAccent,
              content: Text(
                "Wrong Password Provided by User",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
        }
      }
    } else {
      print("No Parents Found for that Mobile number");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          // backgroundColor: Colors.lightBlueAccent,
          content: Text(
            "No Parents Found for that Mobile number",
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ),
      );
    }
  }

  bool _showPassword = false;

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      // child: SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            maxLength: 10,
            autofocus: false,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              hintText: "Your Mobile Number",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
              errorStyle: TextStyle(fontSize: 15),
            ),
            controller: emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter Mobile Number';
              } else if (value.length != 10) {
                return 'Please Enter Valid Mobile Number';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              autofocus: false,
              obscureText: !_showPassword,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(
                      _showPassword ? Icons.lock_open : Icons.lock_outline),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: _togglePasswordVisibility,
                ),
                errorStyle: const TextStyle(fontSize: 15),
              ),
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Password';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: defaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      number = emailController.text;
                      password = passwordController.text;
                    });
                    check();
                  }
                },
                child: Text(
                  "Login".toUpperCase(),
                ),
              ),
              // TextButton(
              //     onPressed: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => ForgotPassword()),
              //       );
              //     },
              //     child: const Text(
              //       "Forgot Password ?",
              //       style: TextStyle(
              //           color: kPrimaryColor,
              //           fontWeight: FontWeight.bold,
              //           decoration: TextDecoration.underline),
              //     )),
            ],
          ),

          //   const SizedBox(height: defaultPadding),
          //   AlreadyHaveAnAccountCheck(
          //     press: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) {
          //             return const SignUpScreen();
          //           },
          //         ),
          //       );
          //     },
          //   ),
        ],
      ),
    );
  }
}
