import 'package:flutter/material.dart';
import 'package:seniorsteps/widgets/item.dart';




class Listing extends StatefulWidget {
  @override
  _ListingState createState() => _ListingState();
}

class _ListingState extends State<Listing> with TickerProviderStateMixin {

TabController tabController;

@override
void initState() {
  tabController = TabController(initialIndex: 1, length: 2, vsync: this);
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Listing',
          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight:  FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.black, size: 20.0),
        bottom: PreferredSize(
          preferredSize: Size(0.0, 30.0),
          child: TabBar(
            tabs: [
              Text('Active'), Text('Inactive')
            ],
            controller: tabController,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: Colors.black, width: 0.5)
            ),
            labelStyle: TextStyle(color: Colors.black, fontSize: 15.0),
            unselectedLabelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        child: TabBarView(
          controller: tabController,
          children: [
            Active(),
            InActive()
          ],
        ),
      ),
    );
  }
}



class Active extends StatefulWidget {
  @override
  _ActiveState createState() => _ActiveState();
}

class _ActiveState extends State<Active> {

List images = [
  'assets/villa.jpg', 'assets/apartment.jpg', 'assets/chalet.jpg', 'assets/office.jpg'
];


List names = [
  'Villa', 'Apartment', 'Chalet', 'Office'
];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: names.length,
        itemBuilder: (context, index){
          return Item(names[index], images[index], 'active');
        },
      ),
    );
  }
}



class InActive extends StatefulWidget {
  @override
  _InActiveState createState() => _InActiveState();
}

class _InActiveState extends State<InActive> {

List images = [
  'assets/villa.jpg', 'assets/apartment.jpg', 'assets/chalet.jpg', 'assets/office.jpg'
];


List names = [
  'Villa', 'Apartment', 'Chalet', 'Office'
];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: names.length,
        itemBuilder: (context, index){
          return Item(names[index], images[index], 'active');
        },
      ),
    );
  }
}