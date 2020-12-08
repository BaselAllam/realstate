import 'package:flutter/material.dart';
import 'package:seniorsteps/widgets/homePageItem.dart';



class AllListingMedia extends StatefulWidget {
  @override
  _AllListingMediaState createState() => _AllListingMediaState();
}

class _AllListingMediaState extends State<AllListingMedia> {

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
        title: Text(
          'All Lisiting Media',
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
        margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 0.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            childAspectRatio: 1
          ),
          scrollDirection: Axis.vertical,
          itemCount: names.length,
          itemBuilder: (context, index){
            return HomePageItem(images[index], names[index]);
          },
        ),
      ),
    );
  }
}