import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:seniorsteps/models/mainmodel.dart';
import 'package:seniorsteps/screens/allListingMedia.dart';
import 'package:seniorsteps/screens/more/about.dart';
import 'package:seniorsteps/screens/more/contact.dart';
import 'package:seniorsteps/screens/more/profile.dart';
import 'package:seniorsteps/screens/more/setting.dart';
import 'package:seniorsteps/screens/searchResult.dart';
import 'package:seniorsteps/screens/splashscreens.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {

@override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: MainModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SpalshScreens(),
        routes: {
          'allListingMedia' : (context) => AllListingMedia(),
          'setting' : (context) => Setting(),
          'aboutUs' : (context) => AboutUs(),
          'contactUs' : (context) => ContactUs(),
          'myAccount' : (context) => Profile(),
          'result' : (context) => SearchResult()
        },
      ),
    );
  }
}