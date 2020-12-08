import 'package:flutter/material.dart';
import 'package:seniorsteps/widgets/item.dart';




class SearchResult extends StatefulWidget {
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {

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
            'Result',
            style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight:  FontWeight.bold),
          ),
        iconTheme: IconThemeData(color: Colors.black, size: 20.0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size(0.0, 50.0),
          child: ListTile(
            trailing: Icon(Icons.filter_list),
            leading: Text(
              '${names.length.toString()} items',
              style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight:  FontWeight.bold),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: names.length,
          itemBuilder: (context, index){
            return Item(names[index], images[index], 'result');
          },
        ),
      ),
    );
  }
}