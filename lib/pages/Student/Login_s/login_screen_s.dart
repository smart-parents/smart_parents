import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:smart_parents/components/background.dart';
import 'package:smart_parents/components/responsive.dart';
import 'package:smart_parents/pages/Student/Login_s/components_s/login_form_s.dart';
import 'package:smart_parents/pages/Student/Login_s/components_s/login_screen_top_image_s.dart';

class LoginScreenS extends StatelessWidget {
  const LoginScreenS({Key? key}) : super(key: key);

  locationData() async {
    // Create a Location instance
    Location location = Location();
    // location.enableBackgroundMode(enable: true);
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus != PermissionStatus.granted) {
      // Request the location permission if not granted
      await location.requestPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    locationData();
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: const MobileLoginScreen(),
          desktop: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                child: LoginScreenTopImage(),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 450,
                      child: LoginForm(),
                    ),
                    // SizedBox(height: defaultPadding / 2),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // scrollDirection: Axis.vertical,
      // scrollDirection: Axis.horizontal,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const LoginScreenTopImage(),
          Row(
            children: const [
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
