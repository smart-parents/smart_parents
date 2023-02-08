import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Profile_screen extends StatefulWidget {
  const Profile_screen({super.key});

  @override
  State<Profile_screen> createState() => _Profile_screenState();
}

class _Profile_screenState extends State<Profile_screen> {
  get fid => null;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 590.0,
        width: 414.0,
        color: Colors.blue[50],
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/Photo/Dhruvin.jpg'),
            ),
            Text(
              'Dhruvin Katakiya',
              style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            Container(
              height: 470.0,
              width: 365.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Color.fromARGB(255, 37, 86, 116),
              ),
              // alignment: Alignment(0.0, -0.9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    " User ID:$fid",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  Text(
                    // alignment: Alignment(0.0, -0.8),
                    " User ID8: $fid",
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
