import 'package:flutter/material.dart';
// import 'package:smart_parents/pages/check.dart';
import 'package:smart_parents/pages/option.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: "get_start_btn",
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const Option();
                  },
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              // minimumSize: const Size.fromHeight(50),
            ),
            child: Text(
              "Get Started".toUpperCase(),
            ),
          ),
        ),
      ],
    );
  }
}
