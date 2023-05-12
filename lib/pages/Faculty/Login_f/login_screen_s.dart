import 'package:flutter/material.dart';
import 'package:smart_parents/components/background.dart';
// import 'package:smart_parents/components/responsive.dart';
import 'package:smart_parents/pages/Faculty/Login_f/components_f/login_form_f.dart';
import 'package:smart_parents/pages/Faculty/Login_f/components_f/login_screen_top_image_f.dart';

class LoginScreenF extends StatelessWidget {
  const LoginScreenF({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Background(
      child: SingleChildScrollView(
        child: 
        // Responsive(
        //   mobile: 
          MobileLoginScreen(),
          // desktop: Row(
          //   // mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Expanded(
          //       child: LoginScreenTopImage(),
          //     ),
          //     Expanded(
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           SizedBox(
          //             width: 450,
          //             child: LoginForm(),
          //           ),
          //           // SizedBox(height: defaultPadding / 2),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        ),
      // ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      // scrollDirection: Axis.vertical,
      // scrollDirection: Axis.horizontal,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LoginScreenTopImage(),
          Row(
            children: [
              Spacer(),
              Expanded(
                flex: 8,
                child: LoginForm(),
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
