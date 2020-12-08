import 'package:flutter/material.dart';
import 'package:seniorsteps/widgets/homePageItem.dart';
import 'package:seniorsteps/widgets/item.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

List images = [
  'assets/villa.jpg', 'assets/apartment.jpg', 'assets/chalet.jpg', 'assets/office.jpg', 'assets/agriculture.jpg', 'assets/retail.jpg'
];


List names = [
  'Villa', 'Apartment', 'Chalet', 'Office', 'agriculture', 'retails', 
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/pp.png'),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(Icons.search),
              color: Colors.teal,
              iconSize: 25.0,
              onPressed: () {
                Navigator.pushNamed(context, 'result');
              },
            ),
          )
        ],
        iconTheme: IconThemeData(color: Colors.black, size: 20.0),
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 2.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Text(
              'Welcome Bassel\nfind best deals around the world',
              style: TextStyle(color: Colors.grey, fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: Text(
                'Listing Media',
                style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              trailing: Text(
                'view all',
                style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.normal),
              ),
              onTap: () {
                Navigator.pushNamed(context, 'allListingMedia');
              },
            ),
            Container(
              height: MediaQuery.of(context).size.height/3.8,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return HomePageItem(images[index], names[index]);
                },
              )
            ),
            ListTile(
              title: Text(
                'Recently Added',
                style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.replay, color: Colors.grey, size: 20.0),
            ),
            Item(names[0], images[0], 'homePage'),
            Item(names[1], images[1], 'homePage'),
            Item(names[2], images[2], 'homePage'),
            Item(names[3], images[3], 'homePage'),
          ],
        ),
      ),
    );
  }
}