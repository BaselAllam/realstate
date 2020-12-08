import 'package:flutter/material.dart';
import 'package:seniorsteps/widgets/item.dart';



class Saved extends StatefulWidget {
  @override
  _SavedState createState() => _SavedState();
}

class _SavedState extends State<Saved> {

List images = [
  'assets/villa.jpg', 'assets/apartment.jpg', 'assets/chalet.jpg', 'assets/office.jpg'
];


List names = [
  'Villa', 'Apartment', 'Chalet', 'Office'
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Saved',
          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight:  FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.black, size: 20.0),
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: names.length,
          itemBuilder: (context, index){
            return Item(names[index], images[index], 'saved');
          },
        ),
      ),
    );
  }
}