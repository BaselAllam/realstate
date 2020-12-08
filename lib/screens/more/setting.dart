//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Setting',
          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight:  FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.black, size: 20.0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
        child: Column(
          children: [
            ListTile(
              title: Text(
                  'App Language',
                  style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight:  FontWeight.bold),
                ),
              subtitle: Text(
                  'English',
                  style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight:  FontWeight.bold),
                ),
              leading: Icon(Icons.language, color: Colors.grey, size: 20.0),
              trailing: Icon(Icons.arrow_downward, color: Colors.grey, size: 20.0),
            ),
            ListTile(
              title: Text(
                  'App Version',
                  style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight:  FontWeight.bold),
                ),
              subtitle: Text(
                  '1.5',
                  style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight:  FontWeight.bold),
                ),
              leading: Icon(Icons.system_update, color: Colors.grey, size: 20.0),
            ),
            FlatButton(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  child: Text(
                    'Sign Out',
                    style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    SharedPreferences user = await SharedPreferences.getInstance();
                    user.clear();
                    //exit(0);
                  },
                ),
          ],
        ),
      ),
    );
  }
}