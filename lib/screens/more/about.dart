import 'package:flutter/material.dart';



class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'About Us',
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
                  'Company Data',
                  style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight:  FontWeight.bold),
                ),
              subtitle: Text(
                  'stablished in 2020, working on real state made by a group of developer',
                  style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight:  FontWeight.bold),
                ),
            ),
            Divider(color: Colors.grey, height: 5.0,),
            ListTile(
              title: Text(
                  'Company Vesion',
                  style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight:  FontWeight.bold),
                ),
              subtitle: Text(
                  'Company Vesion is to serve you and make you satisifed',
                  style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight:  FontWeight.bold),
                ),
            ),
          ],
        ),
      ),
    );
  }
}