import 'package:flutter/material.dart';
import 'package:smart_parents/components/constants.dart';

class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // return SingleChildScrollView(
    //   child:
    return Column(
      children: [
        Text(
          "FACULTY LOGIN",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              // child: SvgPicture.asset("assets/images/Admin.svg"),
              child: Image.asset(
                "assets/images/Faculty.png",
                height: screenWidth * 0.5,
              ),
            ),
            const Spacer(),
          ],
        ),
        SizedBox(height: defaultPadding * 2),
      ],
      // ),
    );
  }
}
