import 'package:flutter/material.dart';
import 'package:smart_parents/pages/Parents/attendance_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "Your Today's Classes",
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 15.0, color: Colors.white),
      ),
      // SizedBox(
      //   width: 200,
      //   height: 200,
      // ),
      Container(
        // margin: const EdgeInsets.all(20),
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
        child: ElevatedButton(
          onPressed: () => {
            //Navigator.push(
            // context,
            /*MaterialPageRoute(
                    builder: (context) {
                      return const Student();
                    },
                  ),
                )*/
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            backgroundColor: const Color.fromARGB(255, 37, 86, 116),
            minimumSize: const Size(150, 40),
          ),
          child: const Text(
            'Classes Schedule',
            style: TextStyle(fontSize: 15.0, color: Colors.white),
          ),
        ),
      ),
      Container(
        // margin: const EdgeInsets.all(20),
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
        child: ElevatedButton(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const Attendance_screen();
                },
              ),
            )
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            backgroundColor: const Color.fromARGB(255, 37, 86, 116),
            minimumSize: const Size(150, 40),
          ),
          child: const Text(
            'See Attendence',
            style: TextStyle(fontSize: 15.0, color: Colors.white),
          ),
        ),
      ),
      Container(
        // margin: const EdgeInsets.all(20),
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
        child: ElevatedButton(
          onPressed: () => {},
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            backgroundColor: const Color.fromARGB(255, 37, 86, 116),
            minimumSize: const Size(150, 40),
          ),
          child: const Text(
            'Study Material',
            style: TextStyle(fontSize: 15.0, color: Colors.white),
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            // margin: const EdgeInsets.all(20),
            //margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: ElevatedButton(
              onPressed: () => {
                //Navigator.push(
                // context,
                /*MaterialPageRoute(
                    builder: (context) {
                      return const Student();
                    },
                  ),
                )*/
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                minimumSize: const Size(150, 80),
              ),
              child: const Text(
                'Results',
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
            ),
          ),
          Container(
            // margin: const EdgeInsets.all(20),
            //margin: const EdgeInsets.fromLTRB(0, 0, 5, 40),
            child: ElevatedButton(
              onPressed: () => {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                minimumSize: const Size(150, 80),
              ),
              child: const Text(
                'Exam info',
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            // margin: const EdgeInsets.all(20),
            margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: ElevatedButton(
              onPressed: () => {
                //Navigator.push(
                // context,
                /*MaterialPageRoute(
                    builder: (context) {
                      return const Student();
                    },
                  ),
                )*/
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                minimumSize: const Size(150, 80),
              ),
              child: const Text(
                'Fee details',
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
            ),
          ),
          Container(
            // margin: const EdgeInsets.all(20),
            margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: ElevatedButton(
              onPressed: () => {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                minimumSize: const Size(150, 80),
              ),
              child: const Text(
                'Contact Faculty',
                style: TextStyle(fontSize: 15.0, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ]));
  }
}
