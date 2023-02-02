import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smart_parents/components/constants.dart';
import 'package:smart_parents/pages/Faculty/user_main_f.dart';

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
  var faculty = "";
  var password = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final storage = new FlutterSecureStorage();

  check() async {
    final snapShot = await FirebaseFirestore.instance
        .collection('faculty')
        .where('faculty', isEqualTo: faculty)
        .get();
    if (snapShot.docs.isNotEmpty) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: "$faculty@spf.com", password: password);
        print(userCredential.user?.uid);
        await storage.write(key: "uid", value: userCredential.user?.uid);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => UserMain(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        print(e);
        if (e.code == 'user-not-found') {
          print("No User Found for that Enrollment number");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.lightBlueAccent,
              content: Text(
                "No User Found for that Enrollment number",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
        } else if (e.code == 'wrong-password') {
          print("Wrong Password Provided by User");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.lightBlueAccent,
              content: Text(
                "Wrong Password Provided by User",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
        }
      }
    } else {
      print("No Faculty Found for that Enrollment number");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.lightBlueAccent,
          content: Text(
            "No faculty Found for that Enrollment number",
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ),
      );
    }
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
            maxLength: 4,
            autofocus: false,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: "Your Faculty ID",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
              errorStyle:
                  TextStyle(color: Colors.lightBlueAccent, fontSize: 15),
            ),
            controller: emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter Faculty ID';
              } else if (value.length != 4) {
                return 'Please Enter Valid Faculty ID';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              autofocus: false,
              obscureText: true,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
                errorStyle:
                    TextStyle(color: Colors.lightBlueAccent, fontSize: 15),
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
          Container(
            //margin: EdgeInsets.only(left: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        faculty = emailController.text;
                        password = passwordController.text;
                        // Stream<QuerySnapshot> adminStream = FirebaseFirestore
                        //     .instance
                        //     .collection('Admin')
                        //     .where("email", isEqualTo: email)
                        //     .snapshots();
                        // if (adminStream!=null) {
                        //   userLogin();
                        // }
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
