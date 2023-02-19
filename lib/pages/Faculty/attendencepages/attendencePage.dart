// ignore_for_file: file_names, library_private_types_in_public_api, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:smart_parents/pages/Faculty/attendencepages/util/names.dart';
import 'package:smart_parents/pages/Faculty/attendencepages/util/userPrefrences.dart';

class AttendencePage extends StatefulWidget {
  const AttendencePage({Key? key}) : super(key: key);

  @override
  _AttendencePageState createState() => _AttendencePageState();
}

class _AttendencePageState extends State<AttendencePage> {
  final studentvar = UserPrefrences.studentlist;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Attendence"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15.0,
          ),
          const Center(
            child: Text(
              "Select those who are present and \n     long press for more options",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 550,
            width: 400,
            // color: Colors.orange,
            child: ListView.builder(
                itemCount: studentvar.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildAttendenceCard(context, index)),
            // ListTile(

            // )),
          ),
          const SizedBox(
            height: 25,
          ),
          //
          //
          //
          ElevatedButton(
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Submit Attendence?'),
                // content: const Text('AlertDialog description'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => {
                      ResetState(),
                      // Navigator.of(context).pushAndRemoveUntil(
                      //     MaterialPageRoute(
                      //         builder: (context) => LoginNavScreen()),
                      //     (route) => false)
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
            style: ElevatedButton.styleFrom(fixedSize: const Size(300, 40)),
            child: const Text('Submit'),
          ),
          // ElevatedButton(
          //     onPressed: () => {
          //       AlertDialog(
          //         title: Text("Submit Attendence?"),
          //         actions: [

          //         ],
          //       )
          //     },
          //     child: Text(
          //       "Submit",
          //       style: TextStyle(fontSize: 15),
          //     ),
          // style: ElevatedButton.styleFrom(
          //   shape: new RoundedRectangleBorder(
          //       borderRadius: new BorderRadius.circular(10.0)),
          //   fixedSize: Size(400, 60),
          // )),
        ],
      ),
    );
  }

  buildAttendenceCard(BuildContext context, int index) {
    var index2 = index + 1;

    return FocusedMenuHolder(
      menuWidth: MediaQuery.of(context).size.width * 0.75,
      duration: const Duration(milliseconds: 350),
      animateMenuItems: true,
      onPressed: () {
        setState(() {
          ChangeState(isSelectedList, index, 1);
          ChangeColor(isSelectedList, index);
        });
        // Navigator.of(this.context).push(
        // MaterialPageRoute(builder: (context) => ProfilePage()),
        // );
      },
      menuItems: <FocusedMenuItem>[
        FocusedMenuItem(
            title: const Text(
              "Present",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),
            onPressed: () {
              setState(() {
                ChangeState(isSelectedList, index, 1);
                ChangeColor(isSelectedList, index);
              });
              // Navigator.of(this.context).push(
              //   MaterialPageRoute(builder: (context) => ProfilePage()),
              // );
            },
            backgroundColor: const Color(0xff00CE2D)),
        //00CE2D
        FocusedMenuItem(
            title: const Text(
              "Absent",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            onPressed: () {
              setState(() {
                ChangeState(isSelectedList, index, 0);
                ChangeColor(isSelectedList, index);
              });
              // Navigator.of(this.context).push(
              //   MaterialPageRoute(builder: (context) => EditProfilePage()),
              // );
            },
            backgroundColor: const Color(0xffff0800)),
        // FocusedMenuItem(
        //     title: const Text(
        //       "Leave",
        //       style: TextStyle(
        //           color: Colors.white,
        //           fontSize: 15,
        //           fontWeight: FontWeight.bold),
        //     ),
        //     onPressed: () {
        //       setState(() {
        //         ChangeState(isSelectedList, index, 2);
        //         ChangeColor(isSelectedList, index);
        //       });
        //       // Navigator.of(this.context).push(
        //       //   MaterialPageRoute(builder: (context) => ChangePassword()),
        //       // );
        //     },
        //     backgroundColor: const Color(0xffffc100))
      ],
      child: Card(
        color: attendencecolor[index],
        elevation: 2,
        shadowColor: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Text(
                index2.toString(),
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                width: 25,
              ),
              Text(
                studentvar[index].studentName,
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void ChangeState(List<int> isSelectedList, int value, int i) {
    isSelectedList[value] = i;
  }

  void ResetState() {
    for (int state = 0; state < attendencecolor.length; state++) {
      attendencecolor[state] = Colors.white;
    }
  }

  void ChangeColor(List<int> isSelectedList, int index) {
    if (isSelectedList[index] == 1) {
      attendencecolor[index] = const Color(0xff00CE2D);
      print("changed to : $isSelectedList");
      // } else {
      //   if (isSelectedList[index] == 2) {
      //     attendencecolor[index] = const Color(0xffffc100);
      // print("changed to : $isSelectedList");
    } else {
      attendencecolor[index] = const Color(0xffff0800);
      print("changed to : $isSelectedList");
    }
    // }
  }
}
