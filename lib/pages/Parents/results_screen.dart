import 'package:flutter/material.dart';
import 'package:smart_parents/components/background.dart';

class Results_screen extends StatefulWidget {
  const Results_screen({super.key});

  @override
  State<Results_screen> createState() => _Results_screenState();
}

class _Results_screenState extends State<Results_screen> {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Text('results'.toUpperCase()),
            const Align(
              alignment: Alignment(-0.7, -1),
              child: Text(
                'Results',
                style: TextStyle(
                    height: 5,
                    fontSize: 30.0,
                    color: Color.fromARGB(255, 37, 86, 116)),
              ),
            ),
            Container(
              // margin: const EdgeInsets.all(20),
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: ElevatedButton(
                onPressed: () => {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return const Student();
                  //     },
                  //   ),
                  // )
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                  minimumSize: const Size(250, 50),
                ),
                child: const Text(
                  'Sem 1',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
            Container(
              // margin: const EdgeInsets.all(20),
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: ElevatedButton(
                onPressed: () => {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return const Faculty();
                  //     },
                  //   ),
                  // )
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                  minimumSize: const Size(250, 50),
                ),
                child: const Text(
                  'Sem 2',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
            Container(
              // margin: const EdgeInsets.all(20),
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: ElevatedButton(
                onPressed: () => {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return const Faculty();
                  //     },
                  //   ),
                  // )
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                  minimumSize: const Size(250, 50),
                ),
                child: const Text(
                  'Sem 3',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
            Container(
              // margin: const EdgeInsets.all(20),
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: ElevatedButton(
                onPressed: () => {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return const Faculty();
                  //     },
                  //   ),
                  // )
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                  minimumSize: const Size(250, 50),
                ),
                child: const Text(
                  'Sem 4',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
            Container(
              // margin: const EdgeInsets.all(20),
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: ElevatedButton(
                onPressed: () => {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return const Faculty();
                  //     },
                  //   ),
                  // )
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                  minimumSize: const Size(250, 50),
                ),
                child: const Text(
                  'Sem 5',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
            Container(
              // margin: const EdgeInsets.all(20),
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: ElevatedButton(
                onPressed: () => {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return const Faculty();
                  //     },
                  //   ),
                  // )
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: const Color.fromARGB(255, 37, 86, 116),
                  minimumSize: const Size(250, 50),
                ),
                child: const Text(
                  'Sem 6',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
