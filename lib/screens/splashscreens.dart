import 'package:flutter/material.dart';
import 'package:seniorsteps/screens/bottomnavbar/bottomnavbar.dart';
import 'package:seniorsteps/screens/sign.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';




class SpalshScreens extends StatefulWidget {
  @override
  _SpalshScreensState createState() => _SpalshScreensState();
}

class _SpalshScreensState extends State<SpalshScreens> {

String check;

checkUser() async {
  SharedPreferences user = await SharedPreferences.getInstance();
  String _user = user.getString('email');
  setState(() {
    check = _user;
  });
}

@override
void initState() {
   checkUser();
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreen(
        seconds: 5,
        navigateAfterSeconds: check == null ? Sign() : BottomNavBar(),
        title: Text('Welcome In SplashScreen'),
        image: Image.asset('assets/villa.jpg'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.red
      ),
    );
  }
}