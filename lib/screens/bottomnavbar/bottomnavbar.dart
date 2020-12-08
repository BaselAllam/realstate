import 'package:flutter/material.dart';
import 'package:seniorsteps/screens/bottomnavbar/add.dart';
import 'package:seniorsteps/screens/bottomnavbar/homepage.dart';
import 'package:seniorsteps/screens/bottomnavbar/listing.dart';
import 'package:seniorsteps/screens/bottomnavbar/more.dart';
import 'package:seniorsteps/screens/bottomnavbar/saved.dart';



class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

List screens = [
  HomePage(), Listing(), Add(), Saved(), More()
];

int current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.replay),
            title: Text('Listing')
          ),
          BottomNavigationBarItem(
            icon: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.teal,
                shape: BoxShape.circle
              ),
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(Icons.add, color: Colors.white, size: 30.0),
              )
            ),
            title: Text('')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            title: Text('Saved')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            title: Text('More')
          ),
        ],
        currentIndex: current,
        onTap: (index) {
          setState(() {
            current = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: IconThemeData(color: Colors.teal, size: 20.0),
        unselectedIconTheme: IconThemeData(color: Colors.grey, size: 20.0),
        selectedLabelStyle: TextStyle(color: Colors.teal, fontSize: 10.0),
        unselectedLabelStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
      ),
      body: screens[current],
    );
  }
}